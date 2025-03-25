import 'package:photo_gallery/data/source/remote/gallery.dart';
import 'package:photo_gallery/domain/entities/photo.dart';

class GalleryRepository {
  final GalleryRemote api;

  GalleryRepository(this.api);

  Future<List<PhotoEntity>?> getPhotos({int count = 20}) async {
    final photoModels = await api.getPhotos(limit: count);
    return photoModels;
  }
}
