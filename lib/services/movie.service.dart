import 'package:http/http.dart' as http;

const baseurl = "https://api.themoviedb.org/3";
const apiKey = "d501567593ff834b63ac29a78c7b728a";

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

  // static getMoviesList({int currentPage = 1}) async {
  //   try {
  //     final popularMovieUrl = "/movie?api_key=$apiKey&language=en-US";
  //     final finalUrl = baseurl + popularMovieUrl;
  //     final response = await http.get(Uri.parse(finalUrl));
  //     if (response.statusCode == 200) {
  //       return response.body;
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  //
  static getSearchMoviesList({
    required String searchQuery,
    int currentPage = 1,
  }) async {
    try {
      final searchUrl =
          "/search/movie?api_key=$apiKey&language=en-US&query=$searchQuery&page=$currentPage&include_adult=false";
      final finalUrl = baseurl + searchUrl;
      final response = await http.get(Uri.parse(finalUrl));
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }
}
