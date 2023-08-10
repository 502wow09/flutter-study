import 'package:flutter/material.dart';
import 'package:image_search/di/provider_setup.dart';
import 'package:image_search/presentation/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    //Provider를 child에 넣는 구조
    MultiProvider(
      providers: globalProviders,
      child: const MyApp(),
    ),
  );
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
      home: const HomeScreen(),
    );
  }
}
