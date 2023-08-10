import 'package:image_search/data/data_source/PixabayApi.dart';
import 'package:image_search/data/repository/pixabay_api.dart';
import 'package:image_search/domain/repository/photo_api_repository.dart';
import 'package:image_search/domain/use_case/get_photos_use_case.dart';
import 'package:image_search/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:http/http.dart' as http;

//home: ChangeNotifierProvider(
//         create: (_) => HomeViewModel(GetPhotoUseCase(PhotoApiRepositoryImpl(PixabayApi(http.Client())))),
//         child: const HomeScreen(),
//       ),
//이거를 내부에서부터 차례대로 꺼내 옮기는 거라 보면 됨.

// 1. Provider 전체
// 밑의 Provider들을 ...문법으로 합침
List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

// 2. 독립적인 객체 Model(비지니스 모델)
List<SingleChildWidget> independentModels = [
  //Prov0
  // http.Client()
  Provider<http.Client>(
    create: (context) => http.Client(),
  ),
];

// 3. 2번에 의존성이 있는 객체 Model(비지니스 모델)
List<SingleChildWidget> dependentModels = [
  //Pro1
  // PixabayApi(http.Client())
  // 위의 Prov0에서 생성된 client가 매개변수 client로 들어오는 거임.

  //ProxyProvider<Provider로 생성된 타입, 리턴할 타입>
  ProxyProvider<http.Client, PixabayApi>(
    update: (context, client, _) => PixabayApi(client),
  ),

  //Prov2
  // PhotoApiRepositoryImpl(PixabayApi(http.Client()))
  // 위의 Prov1에서 생성된 PixabayApi가 매개변수 api로 들어오는 거임.
  ProxyProvider<PixabayApi, PhotoApiRepository>(
    update: (context, api, _) => PhotoApiRepositoryImpl(api),
  ),

  //Prov3
  // GetPhotoUseCase(PhotoApiRepositoryImpl(PixabayApi(http.Client())))
  // 위의 Prov2에서 생성된 PhotoApiRepositoryImpl이 매개변수 repository로 들어오는 거임.
  ProxyProvider<PhotoApiRepository, GetPhotoUseCase>(
    update: (context, repository, _) => GetPhotoUseCase(repository),
  ),
];

// 4. ViewModels
List<SingleChildWidget> viewModels = [
  //Prov5
  // HomeViewModel(GetPhotoUseCase(PhotoApiRepositoryImpl(PixabayApi(http.Client()))))
  // Prov3에서 생성된 GetPhotoUseCase를 매개변수 말고 context로 받음(매개변수로 받는 것도 물론 가능)
  ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(context.read<GetPhotoUseCase>())),
];
