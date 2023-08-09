import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:image_search/data/data_source/result.dart';
import 'package:image_search/domain/model/photo.dart';
import 'package:image_search/domain/repository/photo_api_repository.dart';
import 'package:image_search/presentation/home/home_ui_event.dart';

class HomeViewModel with ChangeNotifier {
  final PhotoApiRepository repository;

  List<Photo> _photos = [];

  //외부에서 getter로만 얻는 게 가능하게 직접 수정뿐만 아니라 .add() .clear() 등도 함수를 통한 수정도 못하게 막는 객체
  UnmodifiableListView<Photo> get photos => UnmodifiableListView(_photos);

  final _eventController = StreamController<HomeUiEvent>();
  Stream<HomeUiEvent> get eventStream => _eventController.stream;

  HomeViewModel(this.repository);

  Future<void> fetch(String query) async {
    final Result<List<Photo>> result = await repository.fetch(query);

    result.when(
      Success: (photos) {
        _photos = photos;
        //ChangeNotifier 안에서 notifyListeners()를 호출하면, 감시하고 있는 곳에 화면을 다시 그릴 거라는 알림을 줌.
        notifyListeners();
      },
      Error: (message) {
        _eventController.add(HomeUiEvent.showSnackBar(message));
      },
    );
  }
}
