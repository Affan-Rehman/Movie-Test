import 'package:flutter/material.dart';
import './controllers/movie.controller.dart';
import 'package:provider/provider.dart';

import 'screens/homepage.screen.dart';
import 'controllers/search.controller.dart';
import 'screens/mainscreen.dart';

void main() {
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
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
