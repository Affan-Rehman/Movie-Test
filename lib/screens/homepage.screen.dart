import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_test/models/movie.model.dart';
import 'package:movie_test/screens/moviedetails.screen.dart';
import 'package:movie_test/controllers/search.controller.dart';
import 'package:movie_test/screens/search.screen.dart';
import 'package:movie_test/widgets/text.widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

    return Scaffold(
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
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 40,
                                  decoration: decoration,
                                  child: TextFormField(
                                    controller: searchController,
                                    cursorColor: Colors.black,
                                    onChanged: (value) {
                                      searchCtr.updateSearchText(value);
                                      List<MovieResultsModel> newList = [];

                                      for (var i = 0;
                                          i < searchCtr.namesList.length;
                                          i++) {
                                        if (searchCtr.namesList[i].title!
                                            .toLowerCase()
                                            .toLowerCase()
                                            .contains(value.toLowerCase())) {
                                          newList.add(searchCtr.namesList[i]);
                                        }
                                      }
                                      searchCtr.updateSearchList(newList);
                                      if (value == "") {
                                        searchCtr.updateSearchList(
                                            searchCtr.namesList);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        splashRadius: 0.1,
                                        onPressed: () {
                                          searchController.clear();
                                          searchCtr.updateSearchText("");
                                          searchCtr.updateSearchList(
                                              searchCtr.namesList);
                                        },
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.black,
                                          size: searchController.text != ""
                                              ? 20
                                              : 0,
                                        ),
                                      ),
                                      hintText: 'Search',
                                      contentPadding: const EdgeInsets.only(
                                        top: 7,
                                        bottom: 10,
                                        left: 10,
                                        right: 10,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  // get the list, if not found, return empty list.
                                  var recentSearchList =
                                      prefs.getStringList('recentsearchlist') ??
                                          [];
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => MovieSearch(
                                          autoSuggestionList: recentSearchList),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.all(7),
                                  decoration: decoration,
                                  child: const Icon(Icons.search),
                                ),
                              )
                            ],
                          ),
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
                                                movieResultsModel:
                                                    searchCtr.searchList[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: displaymovieCard(
                                          image:
                                              "https://image.tmdb.org/t/p/w500/${searchCtr.searchList[index].backdropPath}",
                                          moviename:
                                              searchCtr.searchList[index].title,
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
    );
  }
}
