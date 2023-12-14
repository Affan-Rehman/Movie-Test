import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_test/models/movie.model.dart';
import 'package:movie_test/screens/selectingseats.dart';
import 'package:movie_test/screens/ticketscreen.dart';
import 'package:movie_test/widgets/moviecard.widget.dart';
import 'package:movie_test/widgets/text.widget.dart';

//--testing stationary units
void main() {
  //1 - display text widget
  testWidgets('displayText', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: displayText(
            'Text',
            fontSize: 16.0,
            letterSpacing: 1.0,
            wordSpacing: 2.0,
            leftPadding: 8.0,
            topPadding: 4.0,
            rightPadding: 8.0,
            bottomPadding: 4.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final textWidget = tester.widget<Text>(find.text('Text'));
    expect(textWidget.style!.fontSize, 16.0);
    expect(textWidget.style!.letterSpacing, 1.0);
    expect(textWidget.style!.wordSpacing, 2.0);
    expect(textWidget.style!.fontWeight, FontWeight.bold);

    final paddingWidget = tester.widget<Padding>(find.byType(Padding));
    expect(
        paddingWidget.padding, const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0));
  });

  //2 - movie card widget
  testWidgets('Test moviecard with null image', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: displaymovieCard(moviename: 'Title', image: null),
        ),
      ),
    );

    expect(find.text('Title'), findsOneWidget);
    expect(find.byType(Image), findsNothing);
    expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
  });

  //3 - TicketScreen
  testWidgets('Test TicketScreen widget', (WidgetTester tester) async {
    final movieResultsModel = MovieResultsModel(
      id: 1,
      title: 'Test Movie',
      releaseDate: '2023-12-31',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: TicketScreen(movieResultsModel: movieResultsModel),
      ),
    );

    expect(find.text('Test Movie'), findsOneWidget);
    await tester.pumpAndSettle();
  });

  //4 - Selecting seats screen
  testWidgets('SelectingSeats widget test', (WidgetTester tester) async {
    final MovieResultsModel movie = MovieResultsModel(
      id: 1,
      title: 'Avengers: Endgame',
      releaseDate: '2023-12-31',
      // Add other required attributes for the MovieResultsModel
    );

    await tester.pumpWidget(
      MaterialApp(
        home: SelectingSeats(movieResultsModel: movie),
      ),
    );

    expect(find.text('Avengers: Endgame'), findsOneWidget);
    expect(find.byType(WidgetSeat), findsOneWidget);
    expect(find.byType(WidgetRow), findsOneWidget);
  });
}
