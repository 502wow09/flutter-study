import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_search/data/data_source/PixabayApi.dart';
import 'package:image_search/domain/model/photo.dart';
import 'package:image_search/domain/repository/photo_api_repository.dart';

class PhotoApiRepositoryImpl extends PhotoApiRepository {
  PixabayApi api;
  PhotoApiRepositoryImpl(this.api);

  @override
  Future<List<Photo>> fetch(String query) async {
    final result = await api.fetch(query);
    return result.map((e) => Photo.fromJson(e)).toList();
  }
}
