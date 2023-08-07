import 'dart:convert';

import 'package:image_search/data/photo_api_repository.dart';
import 'package:image_search/model/Photo.dart';
import 'package:http/http.dart' as http;

class PixabayApi extends PhotoApiRepository {
  static const baseUrl = 'https://pixabay.com';
  static const key = '38550726-0dfa18b64c6d5292f82824859';

  @override
  Future<List<Photo>> fetch(String query, {http.Client? client}) async {
    // if (client == null) {
    //   client = http.Client();
    // }
    client ??= http.Client();

    final response = await client.get(Uri.parse(
        '$baseUrl/api/?key=$key&q=$query&image_type=photo'));
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];
    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}
