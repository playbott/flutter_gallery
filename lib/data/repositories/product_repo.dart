import 'package:photo_gallery/data/source/remote/product.dart';
import 'package:photo_gallery/domain/entities/product.dart';

class ProductRepository {
  final ProductRemote api;

  ProductRepository(this.api);

  Future<List<ProductEntity>?> getProducts({int count = 20}) async {
    final products = await api.getProducts(limit: count);
    return products;
  }
}
