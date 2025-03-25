import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:photo_gallery/bloc/app/message/message_bloc.dart';
import 'package:photo_gallery/bloc/product/product_bloc.dart';
import 'package:photo_gallery/core/enums/notification_type.dart';
import 'package:photo_gallery/data/model/product.dart';
import 'package:photo_gallery/data/repositories/product_repo.dart';

class MockProductRepository extends Mock implements ProductRepository {}

class MockStorage extends Mock implements Storage {}

void main() {
  late ProductBloc productBloc;
  late MockProductRepository mockProductRepository;
  late MockStorage mockStorage;

  final products = [
    ProductModel(
      id: 1,
      title: 'Essence Mascara Lash Princess',
      images: [
        'https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png',
      ],
      thumbnailUrl:
          'https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png',
    ),
  ];

  setUp(() async {
    mockProductRepository = MockProductRepository();
    mockStorage = MockStorage();

    when(() => mockStorage.read(any())).thenReturn(null);
    when(() => mockStorage.write(any(), any())).thenAnswer((_) async {});
    HydratedBloc.storage = mockStorage;

    productBloc = ProductBloc(mockProductRepository);
    registerFallbackValue(
      GlobalMessageEventShow(
        title: 'dummy',
        message: 'dummy',
        type: NotificationType.info,
      ),
    );
  });

  tearDown(() {
    productBloc.close();
  });

  group('ProductBloc', () {
    //Test #1
    blocTest<ProductBloc, ProductState>(
      'emits [ProductLoading, ProductCompleted] when sucvcess',
      build: () {
        when(
          () => mockProductRepository.getProducts(count: 20),
        ).thenAnswer((_) async => products);
        return productBloc;
      },
      act: (bloc) => bloc.add(FetchProducts()),
      expect: () => [ProductLoading(), ProductCompleted(products)],
    );

    //Test #2
    blocTest<ProductBloc, ProductState>(
      'emits [ProductLoading, ProductCompleted] from cache when failed',
      build: () {
        when(
          () => mockProductRepository.getProducts(count: 20),
        ).thenThrow(Exception('API error'));
        when(() => mockStorage.read('ProductBloc')).thenReturn({
          'products': [
            {
              'id': 1,
              'title': 'Essence Mascara Lash Princess',
              'images': [
                'https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png',
              ],
              'thumbnail':
                  'https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png',
            },
          ],
        });
        return productBloc;
      },
      act: (bloc) => bloc.add(FetchProducts()),
      expect: () => [ProductLoading(), ProductCompleted(products)],
    );

    //Test #3
    blocTest<ProductBloc, ProductState>(
      'emits [ProductLoading, ProductFailed] when API fails and no cache',
      build: () {
        when(
          () => mockProductRepository.getProducts(count: 20),
        ).thenThrow(Exception('API error'));
        when(
          () => mockStorage.read('ProductBloc'),
        ).thenReturn(null); // Нет кэша
        return productBloc;
      },
      act: (bloc) => bloc.add(FetchProducts()),
      expect:
          () => [
            ProductLoading(),
            ProductFailed('couldn\'t load products: Exception: API error'),
          ],
    );

    //Test #4
    test('toJson/fromJson works correctly', () {
      final state = ProductCompleted(products);
      final json = productBloc.toJson(state);
      expect(json, {
        'products': [
          {
            'id': 1,
            'title': 'Essence Mascara Lash Princess',
            'images': [
              'https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png',
            ],
            'thumbnail':
                'https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png',
          },
        ],
      });

      final restoredState = productBloc.fromJson(json!);
      expect(restoredState, isA<ProductCompleted>());
      expect((restoredState as ProductCompleted).products.length, 1);
      expect(restoredState.products[0].title, 'Essence Mascara Lash Princess');
    });
  });
}
