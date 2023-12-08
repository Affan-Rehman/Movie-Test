import 'package:flutter/material.dart';
import 'package:movie_test/models/movie.model.dart';
import 'package:movie_test/widgets/text.widget.dart';
import 'package:intl/intl.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieResultsModel movieResultsModel;
  const MovieDetailsScreen({Key? key, required this.movieResultsModel})
      : super(key: key);

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
                          "https://image.tmdb.org/t/p/w500/${movieResultsModel.backdropPath}"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            ("In Theaters ${formatDate(movieResultsModel.releaseDate)}"),
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
                                // Add the functionality to launch the corresponding screen
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
                                // Add the functionality to launch the corresponding screen
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
                        children: movieResultsModel.genreIds?.map((genreId) {
                              final genre = MovieResultsModel.genres[genreId];
                              Color genreColor = Colors.blue; // Default color

                              if (genreId == 28) {
                                genreColor = const Color(0xFF15D2BC); // Action
                              } else if (genreId == 12) {
                                genreColor =
                                    const Color(0xFF008000); // Adventure
                              } else if (genreId == 16) {
                                genreColor =
                                    const Color(0xFFFFA500); // Animation
                              } else if (genreId == 35) {
                                genreColor = const Color(0xFF7FFF00); // Comedy
                              } else if (genreId == 80) {
                                genreColor = const Color(0xFF8B0000); // Crime
                              } else if (genreId == 99) {
                                genreColor =
                                    const Color(0xFFFFD700); // Documentary
                              } else if (genreId == 18) {
                                genreColor = const Color(0xFF0000FF); // Drama
                              } else if (genreId == 53) {
                                genreColor =
                                    const Color(0xFFE26CA5); // Thriller
                              } else if (genreId == 10751) {
                                genreColor = const Color(0xFF00FFFF); // Family
                              } else if (genreId == 14) {
                                genreColor = const Color(0xFF8A2BE2); // Fantasy
                              } else if (genreId == 36) {
                                genreColor = const Color(0xFFA0522D); // History
                              } else if (genreId == 27) {
                                genreColor = const Color(0xFF8B008B); // Horror
                              } else if (genreId == 10402) {
                                genreColor = const Color(0xFFDA70D6); // Music
                              } else if (genreId == 9648) {
                                genreColor = const Color(0xFF2F4F4F); // Mystery
                              } else if (genreId == 10749) {
                                genreColor = const Color(0xFFFF00FF); // Romance
                              } else if (genreId == 878) {
                                genreColor =
                                    const Color(0xFF564CA3); // Science Fiction
                              } else if (genreId == 10770) {
                                genreColor =
                                    const Color(0xFFD2691E); // TV Movie
                              }

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
                        movieResultsModel.overview.toString(),
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
                    movieResultsModel.title.toString(),
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
    return "$formattedDate";
  } else {
    return "Release date unavailable"; // or any default message when date is not available
  }
}
