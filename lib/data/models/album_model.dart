// lib/data/models/album_model.dart
class Album {
  final int userId;
  final int id;
  final String title;

  Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }

  // For convenience when inserting to DB
  static Album fromMap(Map<String, dynamic> map) {
    return Album(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
    );
  }
}
