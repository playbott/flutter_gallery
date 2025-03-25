import 'package:flutter_bloc/flutter_bloc.dart';

import 'gallery_bloc.dart';
import 'package:photo_gallery/data/repositories/repositories.dart';

export 'gallery_event.dart';
export 'gallery_state.dart';


class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GalleryRepository repository;

  GalleryBloc(this.repository) : super(GalleryInitial()) {
    on<FetchPhotos>(_onFetchPhotos);
  }

  Future<void> _onFetchPhotos(FetchPhotos event, Emitter<GalleryState> emit) async {
    emit(GalleryLoading());
    try {
      final photos = await repository.getPhotos();
      if (photos != null) {
        emit(GalleryCompleted(photos));
      } else {
        emit(GalleryError('couldn\'t fetch photos'));
      }
    } catch (e) {
        emit(GalleryError(e.toString()));
    }
  }

}