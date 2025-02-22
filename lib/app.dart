import 'package:albums_task/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/album/album_bloc.dart';
import 'blocs/photo/photo_bloc.dart';
import 'data/providers/api_provider.dart';
import 'data/repositories/album_repository.dart';
import 'data/repositories/photo_repository.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    final albumRepository = AlbumRepository(apiProvider);
    final photoRepository = PhotoRepository(apiProvider);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AlbumBloc>(
          create: (context) => AlbumBloc(albumRepository),
        ),
        BlocProvider<PhotoBloc>(
          create: (context) => PhotoBloc(photoRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Infinite Scroll Albums',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomePage(),
      ),
    );
  }
}