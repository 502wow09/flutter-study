import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:image_search/data/photo_api_repository.dart';
import 'package:image_search/model/photo.dart';

class HomeViewModel with ChangeNotifier {
  final PhotoApiRepository repository;

  List<Photo> _photos = [];
  //외부에서 getter로만 얻는 게 가능하게 직접 수정뿐만 아니라 .add() .clear() 등도 함수를 통한 수정도 못하게 막는 객체
  UnmodifiableListView<Photo> get photos => UnmodifiableListView(_photos);

  HomeViewModel(this.repository);

  Future<void> fetch(String query) async {
    final result = await repository.fetch(query);
    _photos = result;

    //ChangeNotifier 안에서 notifyListeners()를 호출하면, 감시하고 있는 곳에 화면을 다시 그릴 거라는 알림을 줌.
    notifyListeners();
  }
}