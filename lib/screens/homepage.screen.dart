import 'package:flutter/material.dart';
import 'package:movie_test/screens/moviedetails.screen.dart';
import 'package:movie_test/controllers/search.controller.dart';
import 'package:provider/provider.dart';
import '../controllers/movie.controller.dart';
import '../widgets/moviecard.widget.dart';

class MoviesHomePage extends StatefulWidget {
  const MoviesHomePage({super.key});

  @override
  State<MoviesHomePage> createState() => _MoviesHomePageState();
}

class _MoviesHomePageState extends State<MoviesHomePage> {
  final decoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(7),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 2,
        spreadRadius: 2,
      )
    ],
  );
  var movieList = MovieServiceController();
  var searchPvr = MySearchController();
  final searchController = TextEditingController();
  @override
  void initState() {
    searchPvr = Provider.of<MySearchController>(context, listen: false);
    movieList = Provider.of<MovieServiceController>(context, listen: false);
    context.read<MovieServiceController>().getPopularMovies().then((_) {
      Future.delayed(Duration.zero, () {
        searchPvr.updateSearchList(movieList.movieList);
        searchPvr.namesList = movieList.movieList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6FA),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Consumer<MovieServiceController>(
            builder: (context, movieService, child) {
              if (movieService.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    color: Colors.white,
                  ),
                );
              } else {
                return Consumer<MySearchController>(
                  builder: (context, searchCtr, child) {
                    if (searchPvr.namesList.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Movies Found 🧐",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisExtent: 200,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                ),
                                itemCount: searchCtr.namesList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => MovieDetailsScreen(
                                            movieResultsModel:
                                                searchCtr.namesList[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: displaymovieCard(
                                      image:
                                          "https://image.tmdb.org/t/p/w500/${searchCtr.namesList[index].backdropPath}",
                                      moviename:
                                          searchCtr.namesList[index].title,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
