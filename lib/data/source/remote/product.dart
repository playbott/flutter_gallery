import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:photo_gallery/data/model/product.dart';
import 'package:photo_gallery/domain/entities/product.dart';
import 'package:photo_gallery/environment.gen.dart';
import 'package:photo_gallery/utils/utils.dart';

class ProductRemote {
  Future<List<ProductEntity>?> getProducts({int limit = 20}) async {
    final response = await http.get(
      Uri.parse('${Env.dummyJsonApiUrl}/products?limit=$limit'),
    );

    if (response.statusCode == 200) {
      final List<ProductEntity>? products;
      try {
        products = ProductModel.products(jsonDecode(response.body));
      } catch (e) {
        throw Exception('failed to load products');
      }
      return products;
    } else {
      throw handleError(response);
    }
  }
}
