import 'dart:convert';

import 'package:image_search/model/Photo.dart';
import 'package:http/http.dart' as http;

class PixabayApi {
  final baseUrl = 'https://pixabay.com';
  final key = '38550726-0dfa18b64c6d5292f82824859';

  Future<List<Photo>> fetch(String query) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/api/?key=$key&q=$query&image_type=photo'));
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];
    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}
