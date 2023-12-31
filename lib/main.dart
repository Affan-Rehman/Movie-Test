// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_test/adapters/moviemodeladapter.dart';
import 'package:movie_test/constants.dart';
import 'package:movie_test/models/movie.model.dart';
import './controllers/movie.controller.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'controllers/search.controller.dart';
import 'screens/mainscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity/connectivity.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    connectivity =
        await Connectivity().checkConnectivity() == ConnectivityResult.wifi;
  } catch (e) {
    log(e.toString());
  }
  Hive.registerAdapter<MovieResultsModel>(MovieResultsModelAdapter());
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  final box = await Hive.openBox<MovieResultsModel>('movieBox');
  local = box.isNotEmpty;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MySearchController()),
        ChangeNotifierProvider(create: (_) => MovieServiceController()),
      ],
      child: MaterialApp(
        theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
      ),
    );
  }
}
