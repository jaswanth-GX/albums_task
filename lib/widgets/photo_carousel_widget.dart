import 'package:albums_task/blocs/photo/photo_bloc.dart';
import 'package:albums_task/blocs/photo/photo_event.dart';
import 'package:albums_task/blocs/photo/photo_state.dart';
import 'package:albums_task/data/models/photo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PhotoCarouselWidget extends StatefulWidget {
  final int albumId;

  const PhotoCarouselWidget({Key? key, required this.albumId}) : super(key: key);

  @override
  _PhotoCarouselWidgetState createState() => _PhotoCarouselWidgetState();
}

class _PhotoCarouselWidgetState extends State<PhotoCarouselWidget> {
  late PageController _pageController;
  List<Photo> photos = [];

  @override
  void initState() {
    super.initState();
    context.read<PhotoBloc>().add(FetchPhotos(widget.albumId));
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8, // For example
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          if (state is PhotoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PhotoLoaded) {
            photos = state.photos;
            if (photos.isEmpty) {
              return const Center(child: Text('No photos found'));
            }

            return PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) {
                final loopedIndex = index % photos.length;
                final photo = photos[loopedIndex];
                return _buildPhotoItem(photo);
              },

              itemCount: 1000000,
            );
          } else if (state is PhotoError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildPhotoItem(Photo photo) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              photo.thumbnailUrl,
              fit: BoxFit.cover,
            ),
          ),
          Text(photo.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
