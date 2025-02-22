// lib/blocs/photo/photo_state.dart
import 'package:albums_task/data/models/photo_model.dart';
import 'package:equatable/equatable.dart';


abstract class PhotoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final List<Photo> photos;
  PhotoLoaded(this.photos);

  @override
  List<Object?> get props => [photos];
}

class PhotoError extends PhotoState {
  final String message;
  PhotoError(this.message);

  @override
  List<Object?> get props => [message];
}
