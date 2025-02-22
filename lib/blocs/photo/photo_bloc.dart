// lib/blocs/photo/photo_bloc.dart
import 'package:albums_task/blocs/photo/photo_event.dart';
import 'package:albums_task/blocs/photo/photo_state.dart';
import 'package:albums_task/data/repositories/photo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoRepository photoRepository;

  PhotoBloc(this.photoRepository) : super(PhotoInitial()) {
    on<FetchPhotos>((event, emit) async {
      emit(PhotoLoading());
      try {
        final photos = await photoRepository.fetchPhotosByAlbumId(event.albumId);
        emit(PhotoLoaded(photos));
      } catch (e) {
        emit(PhotoError(e.toString()));
      }
    });
  }
}
