import 'dart:convert';

import 'package:http/http.dart' as http;

class PixabayApi {
  final http.Client client;

  PixabayApi(this.client);

  static const baseUrl = 'https://pixabay.com';
  static const key = '38550726-0dfa18b64c6d5292f82824859';

  Future<Iterable> fetch(String query) async {
    final response = await client
        .get(Uri.parse('$baseUrl/api/?key=$key&q=$query&image_type=photo'));
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];
    return hits;
  }
}
