import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:photo_gallery/bloc/app/message/message_bloc.dart';
import 'package:photo_gallery/core/enums/notification_type.dart';
import 'package:photo_gallery/data/model/product.dart';

import 'product_bloc.dart';
import 'package:photo_gallery/data/repositories/repositories.dart';

export 'product_event.dart';
export 'product_state.dart';

class ProductBloc extends HydratedBloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductNotInitialized()) {
    on<FetchProducts>((FetchProducts event, Emitter<ProductState> emit) async {
      emit(ProductLoading());
      try {
        final products = await repository.getProducts(count: event.count);
        if (products != null) {
          emit(ProductCompleted(products));
        } else {
          final savedState = loadFromCache();
          if (savedState != null) {
            emit(savedState);
          } else {
            throw Exception('couldn\'t load products and no cache available');
          }
        }
      } catch (e) {
        globalMessageBloc.add(
          GlobalMessageEventShow(
            title: 'Error',
            message: e.toString(),
            type: NotificationType.error,
          ),
        );
        final savedState = loadFromCache();
        if (savedState != null) {
          emit(savedState);
        } else {
          emit(ProductFailed('couldn\'t load products: $e'));
        }
      }
      if (state is ProductNotInitialized) {
        final cachedState = fromJson(
          HydratedBloc.storage.read(runtimeType.toString()) ?? {},
        );
        if (cachedState != null) {
          emit(cachedState);
        }
      }
    });
  }

  ProductState? loadFromCache() {
    final cachedJson = HydratedBloc.storage.read(runtimeType.toString());
    if (cachedJson != null) {
      return fromJson(cachedJson as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(ProductState state) {
    if (state is ProductCompleted) {
      return {
        'products':
            (state.products as List<ProductModel>)
                .map((product) => product.toMap())
                .toList(),
      };
    }
    return null;
  }

  @override
  ProductState? fromJson(Map<String, dynamic> json) {
    try {
      if (json.containsKey('products')) {
        final productsJson = json['products'] as List<dynamic>;
        final products =
            productsJson
                .map(
                  (productJson) =>
                      ProductModel.fromMap(productJson as Map<String, dynamic>),
                )
                .toList();
        return ProductCompleted(products);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
