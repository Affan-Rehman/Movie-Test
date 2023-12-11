import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_test/controllers/movie.controller.dart';
import 'package:movie_test/controllers/search.controller.dart';
import 'package:movie_test/screens/homepage.screen.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('MoviesHomePage displays movies when loaded',
      (WidgetTester tester) async {
    // Build the widget
// Inside the test function
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          // Provide the necessary providers here
          ListenableProvider<MySearchController>(
            create: (_) => MySearchController(),
          ),
          ChangeNotifierProvider<MovieServiceController>(
            create: (_) => MovieServiceController(),
          ),
        ],
        child: MaterialApp(
          home: MoviesHomePage(),
        ),
      ),
    );

    // Wait for the Future.delayed duration to complete
  });
}
