import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:movie_test/models/movie.model.dart';
import '../services/movie.service.dart';

class MovieServiceController with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPage = 1;
  int get totalPage => _totalPage;

  List<MovieResultsModel> _movieList = [];
  List<MovieResultsModel> get movieList => _movieList;

  Future<void> getPopularMovies({int currentPage = 1}) async {
    _isLoading = true;

    try {
      final responseBody =
          await MovieService.getPopularMoviesList(currentPage: currentPage);
      final movieList = json.decode(responseBody);

      final movieListModelData = <MovieResultsModel>[];
      for (var element in movieList['results']) {
        movieListModelData.add(MovieResultsModel.fromJson(element));
      }

      _movieList = movieListModelData.toSet().toList();

      final box = await Hive.openBox<MovieResultsModel>('movieBox');
      for (var movie in _movieList) {
        if (!box.containsKey(movie.id)) {
          box.put(movie.id, movie);
        }
      }

      _currentPage = movieList['page'];
      _totalPage = movieList['total_pages'];

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      print('Error occurred: $error');
    }
  }
}
