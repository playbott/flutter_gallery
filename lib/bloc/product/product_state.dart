import 'package:equatable/equatable.dart';
import 'package:photo_gallery/domain/entities/product.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductNotInitialized extends ProductState {}

class ProductLoading extends ProductState {}

class ProductCompleted extends ProductState {
  final List<ProductEntity> products;

  ProductCompleted(this.products);

  @override
  List<Object> get props => [products];
}

class ProductFailed extends ProductState {
  final String message;
  final List<ProductEntity> products;

  ProductFailed(this.message, [this.products = const []]);

  @override
  List<Object> get props => [message];
}
