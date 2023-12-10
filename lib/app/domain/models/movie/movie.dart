import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies_app/app/domain/models/genre/genre.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/domain/typedefs.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const Movie._();

  factory Movie({
    required int id,
    required List<Genre> genres,
    required String overview,
    required int runtime,

    @JsonKey(readValue: readTitleValue)
    required String title,
    @JsonKey(readValue: readOriginalTitleValue)
    required String originalTitle,
    @JsonKey(readValue: readReleaseDateValue)
    required DateTime releaseDate,

    @JsonKey(name: 'backdrop_path')
    required String? backdropPath,
    @JsonKey(name: 'poster_path')
    required String posterPath,
    @JsonKey(name: 'vote_average')
    required double voteAverage,
    @JsonKey(name: 'vote_count')
    required int voteCount,
  }) = _Movie;

  factory Movie.fromJson(Json json) => _$MovieFromJson(json);

  TrendMedia toMedia() {
    return TrendMedia(
      id: id,
      overview: overview,
      title: title,
      originalTitle: originalTitle,
      releaseDate: releaseDate,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}