import 'package:albums_task/blocs/album/album_bloc.dart';
import 'package:albums_task/blocs/album/album_event.dart';
import 'package:albums_task/blocs/album/album_state.dart';
import 'package:albums_task/data/models/album_model.dart';
import 'package:albums_task/widgets/photo_carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  List<Album> albums = [];

  @override
  void initState() {
    super.initState();
    // Fetch Albums
    context.read<AlbumBloc>().add(FetchAlbums());
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Albums'),
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoaded) {
            albums = state.albums;


            return ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                final loopedIndex = index % albums.length;
                final album = albums[loopedIndex];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Album Title: ${album.title}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // Photo Carousel
                    PhotoCarouselWidget(albumId: album.id),
                    const Divider(),
                  ],
                );
              },
            );
          } else if (state is AlbumError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }
}
