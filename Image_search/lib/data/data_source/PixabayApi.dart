import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_search/data/data_source/result.dart';

class PixabayApi {
  final http.Client client;

  PixabayApi(this.client);

  static const baseUrl = 'https://pixabay.com';
  static const key = '38550726-0dfa18b64c6d5292f82824859';

  Future<Result<Iterable>> fetch(String query) async {
    try {
      final response = await client
          .get(Uri.parse('$baseUrl/api/?key=$key&q=$query&image_type=photo'));
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      Iterable hits = jsonResponse['hits'];
      return Result.Success(hits);
    } catch (e) {
      return const Result.Error('네트워크 에러');
    }
  }
}
