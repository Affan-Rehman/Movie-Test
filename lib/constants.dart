import 'dart:ui';

const baseurl = "https://api.themoviedb.org/3";
const apiKey = "d501567593ff834b63ac29a78c7b728a";
String videoBaseUrl = '';
final Map<int, Color> genreColorMap = {
  28: const Color(0xFF15D2BC), // Action
  12: const Color(0xFF008000), // Adventure
  16: const Color(0xFFFFA500), // Animation
  35: const Color(0xFF7FFF00), // Comedy
  80: const Color(0xFF8B0000), // Crime
  99: const Color(0xFFFFD700), // Documentary
  18: const Color(0xFF0000FF), // Drama
  53: const Color(0xFFE26CA5), // Thriller
  10751: const Color(0xFF00FFFF), // Family
  14: const Color(0xFF8A2BE2), // Fantasy
  36: const Color(0xFFA0522D), // History
  27: const Color(0xFF8B008B), // Horror
  10402: const Color(0xFFDA70D6), // Music
  9648: const Color(0xFF2F4F4F), // Mystery
  10749: const Color(0xFFFF00FF), // Romance
  878: const Color(0xFF564CA3), // Science Fiction
  10770: const Color(0xFFD2691E), // TV Movie
};
