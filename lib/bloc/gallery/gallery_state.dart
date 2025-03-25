import 'package:equatable/equatable.dart';
import 'package:photo_gallery/domain/entities/photo.dart';

abstract class GalleryState extends Equatable {
  @override
  List<Object> get props => [];
}

class GalleryInitial extends GalleryState {}

class GalleryLoading extends GalleryState {}

class GalleryCompleted extends GalleryState {
  final List<PhotoEntity> photos;
  GalleryCompleted(this.photos);
  @override
  List<Object> get props => [photos];
}

class GalleryError extends GalleryState {
  final String message;

  GalleryError(this.message);

  @override
  List<Object> get props => [message];
}