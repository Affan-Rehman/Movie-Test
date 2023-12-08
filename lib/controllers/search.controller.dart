import 'package:flutter/material.dart';
import 'package:movie_test/models/movie.model.dart';

class MySearchController with ChangeNotifier {
  String searchText = '';
  List<MovieResultsModel> namesList = [];
  List<MovieResultsModel> searchList = [];
  List<String> recentSearchList = [];
  updateSearchText(value) {
    searchText = value;
    notifyListeners();
  }

  updateSearchList(List<MovieResultsModel> names) {
    searchList = names;
    notifyListeners();
  }

  updateRecentSearchList({required List<String> recentSearch}) {
    recentSearchList = recentSearch;
    notifyListeners();
  }
}
