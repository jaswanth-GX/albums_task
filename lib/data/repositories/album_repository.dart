import 'package:albums_task/data/models/album_model.dart';
import 'package:albums_task/data/providers/api_provider.dart';
import 'package:albums_task/data/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class AlbumRepository {
  final ApiProvider apiProvider;
  AlbumRepository(this.apiProvider);

  Future<List<Album>> fetchAlbums() async {
    final db = await DBProvider.db.database;

    final cachedAlbums = await db.query('Albums');
    if (cachedAlbums.isNotEmpty) {
      return cachedAlbums.map((map) => Album.fromMap(map)).toList();
    } else {
      final result = await apiProvider.fetchAlbums();
      final albums = result.map((json) => Album.fromJson(json)).toList();
      Batch batch = db.batch();
      for (var album in albums) {
        batch.insert('Albums', album.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit();

      return albums.cast<Album>();
    }
  }
}
