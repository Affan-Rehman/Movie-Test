// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:movie_test/controllers/search.controller.dart';
import 'package:movie_test/models/movie.model.dart';
import 'package:movie_test/screens/moviedetails.screen.dart';
import 'package:movie_test/screens/resultscreen.dart';
import 'package:movie_test/widgets/moviecard.widget.dart';
import 'package:movie_test/widgets/text.widget.dart';
import 'package:provider/provider.dart';

class MovieSearch extends StatelessWidget {
  MovieSearch({super.key});
  final searchController = TextEditingController();
  bool searched = false;
  int itemCount = 2;
  List<MovieResultsModel> newList = [];
  @override
  Widget build(BuildContext context) {
    final searchPvr = Provider.of<MySearchController>(context, listen: false);
    searchPvr.searchText = "";

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6FA),
        body:
            Consumer<MySearchController>(builder: (context, searchCtr, child) {
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.search),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            if (value != "") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          ResultScreen(list: newList)));
                            }
                          },
                          controller: searchController,
                          cursorColor: Colors.black,
                          onChanged: (value) {
                            searchCtr.updateSearchText(value);
                            newList = [];

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
                              searchCtr.updateSearchList(searchCtr.namesList);
                              itemCount = 2;
                              searched = false;
                            } else {
                              itemCount = 1;
                              searched = true;
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'TV Shows, Movies and more',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Color(0xFF827D88)),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (searched) {
                            searchController.clear();
                            searched = false;
                          }
                        },
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          color: Colors.black,
                          onPressed: () {
                            searched
                                ? searchController.clear()
                                : Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                bottom: 0,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(30),
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
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (searchController.text != "")
                                    ? const Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Top Results",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Divider()
                                          ],
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                searchCtr.searchList.isNotEmpty
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: itemCount,
                                          mainAxisExtent: 112,
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
                                                          searchCtr.searchList[
                                                              index],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: searched
                                                  ? displaymovieCard(
                                                      image:
                                                          "https://image.tmdb.org/t/p/w500/${searchCtr.searchList[index].backdropPath}",
                                                      moviename: searchCtr
                                                          .searchList[index]
                                                          .title,
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://image.tmdb.org/t/p/w500/${searchCtr.searchList[index].backdropPath}"),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ));
                                        },
                                      )
                                    : Center(
                                        child: displayText(
                                          "No Movie Found! ",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          topPadding: 30,
                                        ),
                                      ),
                              ],
                            );
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
