import 'package:equatable/equatable.dart';

abstract class GalleryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPhotos extends GalleryEvent {
  final int count;

  FetchPhotos({this.count = 20});
}
