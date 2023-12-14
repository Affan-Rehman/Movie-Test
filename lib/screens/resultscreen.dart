import 'package:flutter/material.dart';
import 'package:movie_test/constants.dart';
import 'package:movie_test/models/movie.model.dart';
import 'package:movie_test/screens/moviedetails.screen.dart';

class ResultScreen extends StatelessWidget {
  final List<MovieResultsModel> list;

  const ResultScreen({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF6F6FA),
        appBar: AppBar(
          title: Text("${list.length} Results Found"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MovieDetailsScreen(
                        movieResultsModel: list[index],
                      ),
                    ),
                  );
                },
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 130,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: connectivity
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w500/${list[index].backdropPath}",
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list[index].title ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  MovieResultsModel
                                          .genres[list[index].genreIds![0]] ??
                                      '',
                                  style:
                                      const TextStyle(color: Color(0xFFDBDBDF)),
                                ),
                              ],
                            ),
                          ),
                          Image.asset("assets/images/options.png")
                        ])),
              );
            }));
  }
}
