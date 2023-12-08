import 'package:flutter/material.dart';
import 'package:movie_test/screens/moviedetails.screen.dart';
import 'package:movie_test/controllers/search.controller.dart';
import 'package:movie_test/widgets/text.widget.dart';
import 'package:provider/provider.dart';
import '../controllers/movie.controller.dart';
import '../widgets/moviecard.widget.dart';

class MoviesHomePage extends StatelessWidget {
  MoviesHomePage({super.key});
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
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final searchPvr = Provider.of<MySearchController>(context, listen: false);
    final movieList =
        Provider.of<MovieServiceController>(context, listen: false);
    context.read<MovieServiceController>().getPopularMovies().then((_) {
      Future.delayed(Duration.zero, () {
        searchPvr.updateSearchList(movieList.movieList);
        searchPvr.namesList = movieList.movieList;
      });
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6FA),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(14),
            child: Consumer<MySearchController>(
              builder: (context, searchCtr, child) {
                return searchPvr.namesList.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2.5,
                        ),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          backgroundColor: Colors.black,
                          color: Colors.white,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            searchCtr.searchList.isNotEmpty
                                ? Padding(
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
                                      itemCount: searchCtr.searchList.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    MovieDetailsScreen(
                                                  movieResultsModel: searchCtr
                                                      .searchList[index],
                                                ),
                                              ),
                                            );
                                          },
                                          child: displaymovieCard(
                                            image:
                                                "https://image.tmdb.org/t/p/w500/${searchCtr.searchList[index].backdropPath}",
                                            moviename: searchCtr
                                                .searchList[index].title,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Center(
                                    child: displayText(
                                      "No Movie Found 🧐 ",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      topPadding: 30,
                                    ),
                                  ),
                          ],
                        ),
                      );
              },
            )),
      ),
    );
  }
}
