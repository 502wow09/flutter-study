import 'dart:math';

import 'package:image_search/data/data_source/result.dart';
import 'package:image_search/domain/model/photo.dart';
import 'package:image_search/domain/repository/photo_api_repository.dart';

class GetPhotoUseCase {
  final PhotoApiRepository repository;
  GetPhotoUseCase(this.repository);

  Future<Result<List<Photo>>> execute(String query) async {
    final result = await repository.fetch(query);

    return result.when(Success: (photos) {
      return Result.Success(photos.sublist(0, min(3, photos.length)));
    }, Error: (message) {
      return Result.Error(message);
    });
  }
}