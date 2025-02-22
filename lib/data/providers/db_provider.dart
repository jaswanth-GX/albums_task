// lib/data/providers/db_provider.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'albums_photos.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create tables
        await db.execute('''
          CREATE TABLE Albums(
            userId INTEGER,
            id INTEGER PRIMARY KEY,
            title TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE Photos(
            albumId INTEGER,
            id INTEGER PRIMARY KEY,
            title TEXT,
            url TEXT,
            thumbnailUrl TEXT
          )
        ''');
      },
    );
  }
}
