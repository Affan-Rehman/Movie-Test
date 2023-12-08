import 'package:hive/hive.dart';
import 'package:movie_test/models/movie.model.dart';

class MovieResultsModelAdapter extends TypeAdapter<MovieResultsModel> {
  @override
  final int typeId = 0; // Unique identifier for the adapter

  @override
  MovieResultsModel read(BinaryReader reader) {
    // Read data from Hive and convert it into MovieResultsModel instance
    final fields = reader.readMap() as Map<dynamic, dynamic>;
    return MovieResultsModel(
      adult: fields['adult'] as bool?,
      backdropPath: fields['backdropPath'] as String?,
      genreIds: (fields['genreIds'] as List<dynamic>?)?.cast<int>(),
      id: fields['id'] as int?,
      originalLanguage: fields['originalLanguage'] as String?,
      originalTitle: fields['originalTitle'] as String?,
      overview: fields['overview'] as String?,
      popularity: fields['popularity'] as double?,
      posterPath: fields['posterPath'] as String?,
      releaseDate: fields['releaseDate'] as String?,
      title: fields['title'] as String?,
      video: fields['video'] as bool?,
      voteAverage: fields['voteAverage'] as double?,
      voteCount: fields['voteCount'] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MovieResultsModel obj) {
    // Write data from MovieResultsModel instance to Hive
    writer.writeMap({
      'adult': obj.adult,
      'backdropPath': obj.backdropPath,
      'genreIds': obj.genreIds,
      'id': obj.id,
      'originalLanguage': obj.originalLanguage,
      'originalTitle': obj.originalTitle,
      'overview': obj.overview,
      'popularity': obj.popularity,
      'posterPath': obj.posterPath,
      'releaseDate': obj.releaseDate,
      'title': obj.title,
      'video': obj.video,
      'voteAverage': obj.voteAverage,
      'voteCount': obj.voteCount,
    });
  }
}
