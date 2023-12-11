import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:movie_test/constants.dart';

final Dio _dio = Dio();

class MovieService {
  static getPopularMoviesList({int currentPage = 1}) async {
    try {
      final popularMovieUrl =
          "/movie/popular?api_key=$apiKey&language=en-US&page=$currentPage";
      final finalUrl = baseurl + popularMovieUrl;
      final response = await http.get(Uri.parse(finalUrl));
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  static void getYoutubeId(int id) async {
    try {
      final response =
          await _dio.get('$baseurl/movie/$id/videos?api_key=$apiKey');

      var youtubeId = response.data['results'][0]['key'];
      videoBaseUrl = youtubeId;
    } catch (error) {
      log("Exception: $error");
    }
  }
}
