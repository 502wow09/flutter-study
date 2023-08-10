import 'package:flutter_test/flutter_test.dart';
import 'package:image_search/data/data_source/result.dart';
import 'package:image_search/domain/model/photo.dart';
import 'package:image_search/domain/repository/photo_api_repository.dart';
import 'package:image_search/domain/use_case/get_photos_use_case.dart';

import '../../lib/presentation/home/home_view_model.dart';

void main() {
  test('Api Stream Test', () async {
    final viewModel = HomeViewModel(GetPhotoUseCase(FakePhotoApiRepository()));

    await viewModel.fetch('apple');

    final result = fakeJson.map((e) => Photo.fromJson(e)).toList();

    expect(viewModel.state.photos, result);
  });
}

class FakePhotoApiRepository extends PhotoApiRepository {
  @override
  Future<Result<List<Photo>>> fetch(String query) async {
    Future.delayed(const Duration(milliseconds: 500));

    return Result.Success(fakeJson.map((e) => Photo.fromJson(e)).toList());
  }
}

List<Map<String, dynamic>> fakeJson = [
  {
    "id": 634572,
    "pageURL":
        "https://pixabay.com/photos/apples-fruits-red-ripe-vitamins-634572/",
    "type": "photo",
    "tags": "apples, fruits, red",
    "previewURL":
        "https://cdn.pixabay.com/photo/2015/02/13/00/43/apples-634572_150.jpg",
    "previewWidth": 100,
    "previewHeight": 150,
    "webformatURL":
        "https://pixabay.com/get/g06a1388d1cf0932395226fbe8d14aa8682f2763e589068715123c6a92a95e7d97593c8a9b20f7959960e6b0b101d7382_640.jpg",
    "webformatWidth": 427,
    "webformatHeight": 640,
    "largeImageURL":
        "https://pixabay.com/get/gd987980abebdeaca9c7e4b8dd7f316c9203580b6261cd6b06908cd60116edfe7ccd3899daa9594bd3f45dafaab2edef5d950ed7002b682824353784ddd586efd_1280.jpg",
    "imageWidth": 3345,
    "imageHeight": 5017,
    "imageSize": 811238,
    "views": 525910,
    "downloads": 318187,
    "collections": 1321,
    "likes": 2404,
    "comments": 200,
    "user_id": 752536,
    "user": "Desertrose7",
    "userImageURL":
        "https://cdn.pixabay.com/user/2016/03/14/13-25-18-933_250x250.jpg"
  },
  {
    "id": 1868496,
    "pageURL":
        "https://pixabay.com/photos/apple-computer-desk-workspace-1868496/",
    "type": "photo",
    "tags": "apple, computer, desk",
    "previewURL":
        "https://cdn.pixabay.com/photo/2016/11/29/08/41/apple-1868496_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/g7e3e82ff24a2414da27833cb64eb596a6988362795a2cd63be54548354a4dc12aaabf010e6e0a3f3fcc3bcd47c7b428cb9b34710048965a6a030e288dc732fb2_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 426,
    "largeImageURL":
        "https://pixabay.com/get/gd2bf538955b74f905e7b5eb425c854b64208461eed7c13415a692609216c83cf29a280a0683c7892e8025bf7749b304ece7802294dcc0f0a380a9dcb3a83443f_1280.jpg",
    "imageWidth": 5184,
    "imageHeight": 3456,
    "imageSize": 2735519,
    "views": 758625,
    "downloads": 558946,
    "collections": 1432,
    "likes": 1102,
    "comments": 285,
    "user_id": 2286921,
    "user": "Pexels",
    "userImageURL":
        "https://cdn.pixabay.com/user/2016/03/26/22-06-36-459_250x250.jpg"
  },
];
