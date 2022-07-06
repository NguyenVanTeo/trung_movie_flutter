import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mt_movie/screens/movie_favourite_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'models/movie_model.dart';
import 'screens/home_screen.dart';

void main() async{
  //Init Hive
  await Hive.initFlutter();

  WidgetsFlutterBinding.ensureInitialized();

  //Use path directory
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocumentDir = appDocDir.path;

  print('appDocumentDir: $appDocumentDir');
  //Register Adapters
  Hive
    ..init(appDocumentDir)
    ..registerAdapter(MovieModelAdapter());
  //Hive.deleteBoxFromDisk('favourite');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
