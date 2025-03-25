import 'image_base.dart';

class PhotoEntity extends ImageBase {
  final int albumId;
  final int id;
  final String title;
  final String url;

  PhotoEntity({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required super.thumbnailUrl,
  });
}