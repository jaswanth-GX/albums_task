// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_app_name/app.dart';


void main() {
  runApp(MyApp());
}


// lib/app.dart


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
        home: HomePage(),
      ),
    );
  }
}
