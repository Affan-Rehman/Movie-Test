import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:movie_test/models/movie.model.dart';

import '../services/movie.service.dart';

enum DataLoadingSate {
  initial,
  loading,
  sucess,
  error,
}

class MovieServiceController with ChangeNotifier {
  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  num _currentPage = 1;
  num get currentPage => _currentPage;

  num _totalPage = 1;
  num get totalPage => _totalPage;

  List<MovieResultsModel> _movieList = [];
  List<MovieResultsModel> get movieList => _movieList;
  set movieListSet(List<MovieResultsModel> movieList) => _movieList = [];

  // recent searches
  List<MovieResultsModel> _recentSearchList = [];
  List<MovieResultsModel> movieListModelData = [];
  List<MovieResultsModel> get recentSearchList => _recentSearchList;
  set searchListSet(List<MovieResultsModel> movieList) =>
      _recentSearchList = [];
  // @desc get popular movie
  Future getPopularMovies({int currentPage = 1}) async {
    storeAndLoadData();
    _movieList = [..._movieList, ...movieListModelData.toSet().toList()];

    notifyListeners();
  }

  void storeAndLoadData() async {
    var box = Hive.box<MovieResultsModel>('movieBox');
    if (box.isNotEmpty) {
      _movieList = box.values.toList();
    }
    final responseBody =
        await MovieService.getPopularMoviesList(currentPage: 1);
    final movieList = json.decode(responseBody);

    for (var element in movieList['results']) {
      movieListModelData.add(MovieResultsModel.fromJson(element));
    }
    _movieList = _movieList.toSet().toList();
    for (var movie in _movieList) {
      if (!box.containsKey(movie.id)) {
        box.put(movie.id, movie);
      }
    }
    _currentPage = movieList['page'];
    _totalPage = movieList['total_pages'];
    notifyListeners();
  }
}
