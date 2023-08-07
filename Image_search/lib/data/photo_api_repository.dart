import 'package:image_search/model/Photo.dart';

abstract class PhotoApiRepository {
  Future<List<Photo>> fetch(String query);
}