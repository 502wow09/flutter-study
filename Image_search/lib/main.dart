import 'package:flutter/material.dart';
import 'package:image_search/data/data_source/PixabayApi.dart';
import 'package:image_search/data/repository/pixabay_api.dart';
import 'package:image_search/presentation/home/home_screen.dart';
import 'package:image_search/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (_) => HomeViewModel(PhotoApiRepositoryImpl(PixabayApi(http.Client()))),
        child: const HomeScreen(),
      ),
    );
  }
}