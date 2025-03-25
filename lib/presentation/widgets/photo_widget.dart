import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/domain/entities/image_base.dart';

class PhotoWidget extends StatelessWidget {
  final ImageBase photo;

  const PhotoWidget({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: FastCachedImage(
        url: photo.thumbnailUrl,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.broken_image));
        },
      ),
    );
  }
}
