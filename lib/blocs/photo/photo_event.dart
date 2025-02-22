// lib/blocs/photo/photo_event.dart
import 'package:equatable/equatable.dart';

abstract class PhotoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPhotos extends PhotoEvent {
  final int albumId;
  FetchPhotos(this.albumId);

  @override
  List<Object?> get props => [albumId];
}
