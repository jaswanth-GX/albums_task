// lib/data/providers/api_provider.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiProvider {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<dynamic>> fetchAlbums() async {
    final response = await http.get(Uri.parse('$baseUrl/albums'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<dynamic>> fetchPhotosByAlbumId(int albumId) async {
    final response =
    await http.get(Uri.parse('$baseUrl/photos?albumId=$albumId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
