import 'image_base.dart';

class ProductEntity extends ImageBase {
  final int id;
  final String title;
  final List<String> images;

  ProductEntity({
    required this.id,
    required this.title,
    required this.images,
    required super.thumbnailUrl,
  });
}
