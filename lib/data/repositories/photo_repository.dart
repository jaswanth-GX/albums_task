// lib/data/repositories/photo_repository.dart

import 'package:albums_task/data/models/photo_model.dart';
import 'package:albums_task/data/providers/api_provider.dart';
import 'package:albums_task/data/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class PhotoRepository {
  final ApiProvider apiProvider;
  PhotoRepository(this.apiProvider);

  Future<List<Photo>> fetchPhotosByAlbumId(int albumId) async {
    final db = await DBProvider.db.database;

    // Check cache
    final cachedPhotos =
    await db.query('Photos', where: 'albumId = ?', whereArgs: [albumId]);
    if (cachedPhotos.isNotEmpty) {
      return cachedPhotos.map((map) => Photo.fromMap(map)).toList();
    } else {
      // Fetch from API
      final result = await apiProvider.fetchPhotosByAlbumId(albumId);
      final photos = result.map((json) => Photo.fromJson(json)).toList();

      // Cache them
      Batch batch = db.batch();
      for (var photo in photos) {
        batch.insert('Photos', photo.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit();

      return photos.cast<Photo>();
    }
  }
}
