import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:photo_gallery/data/model/photo.dart';
import 'package:photo_gallery/domain/entities/photo.dart';
import 'package:photo_gallery/environment.gen.dart';
import 'package:photo_gallery/utils/http.dart';

class GalleryRemote {
  Future<List<PhotoEntity>?> getPhotos({int limit = 20}) async {
    final response = await http.get(Uri.parse('${Env.galleryApiUrl}/photos?_limit=$limit'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<PhotoEntity>? photos;
      try {
        photos =
            data
                .map((json) => PhotoModel.fromMap(json as Map<String, dynamic>))
                .toList();
      } catch (e) {
        throw Exception('Failed to load photos');
      }
      return photos;
    } else {
      throw handleError(response);
    }
  }
}
