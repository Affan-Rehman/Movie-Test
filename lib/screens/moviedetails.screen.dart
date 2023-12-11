// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:movie_test/constants.dart';
import 'package:movie_test/models/movie.model.dart';
import 'package:movie_test/screens/ticketscreen.dart';
import 'package:movie_test/screens/trailerscreen.dart';
import 'package:movie_test/services/movie.service.dart';
import 'package:movie_test/widgets/text.widget.dart';
import 'package:intl/intl.dart';

class MovieDetailsScreen extends StatefulWidget {
  MovieResultsModel movieResultsModel;
  MovieDetailsScreen({Key? key, required this.movieResultsModel})
      : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    MovieService.getYoutubeId(widget.movieResultsModel.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 466,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://image.tmdb.org/t/p/w500/${widget.movieResultsModel.backdropPath}"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            ("In Theaters ${formatDate(widget.movieResultsModel.releaseDate)}"),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => TicketScreen(
                                              movieResultsModel:
                                                  widget.movieResultsModel,
                                            )));
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                'Get Tickets',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: OutlinedButton(
                              onPressed: () {
                                if (!(videoBaseUrl == "")) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => TrailerScreen(
                                              trailerUrl: videoBaseUrl)));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Trailer could not be fetched'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: const BorderSide(color: Colors.blue),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Watch Trailer',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          )
                        ]),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Genres:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: widget.movieResultsModel.genreIds
                                ?.map((genreId) {
                              final genre = MovieResultsModel.genres[genreId];
                              Color genreColor =
                                  genreColorMap[genreId] ?? Colors.blue;

                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: genreColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  genre ?? '',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList() ??
                            [],
                      ),
                      const SizedBox(height: 20),
                      displayText(
                        'Overview',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.movieResultsModel.overview.toString(),
                        textAlign: TextAlign.justify,
                        style: const TextStyle(color: Color(0xFF8F8F8F)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.movieResultsModel.title.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String formatDate(String? dateString) {
  if (dateString != null && dateString.isNotEmpty) {
    // Parse the given date string into a DateTime object
    DateTime parsedDate = DateTime.parse(dateString);

    // Format the date as "In theaters Month day, Year" (e.g., "In theaters December 22, 2021")
    String formattedDate = DateFormat.yMMMMd().format(parsedDate);

    // Prepend "In theaters" to the formatted date
    return formattedDate;
  } else {
    return "Release date unavailable"; // or any default message when date is not available
  }
}
