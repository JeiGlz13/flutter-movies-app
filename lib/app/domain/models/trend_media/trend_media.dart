import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies_app/app/domain/typedefs.dart';

part 'trend_media.freezed.dart';
part 'trend_media.g.dart';

@freezed
class TrendMedia with _$TrendMedia {
  factory TrendMedia({
    required int id,
    required String title,
    required String overview,

    @JsonKey(name: 'original_title')
    required String originalTitle,
    @JsonKey(name: 'release_date')
    required String releaseDate,
    @JsonKey(name: 'poster_path')
    required String posterPath,
    @JsonKey(name: 'backdrop_path')
    required String backdropPath,
    @JsonKey(name: 'vote_average')
    required double voteAverage,
    @JsonKey(name: 'vote_count')
    required int voteCount,
  }) = _Media;

  factory TrendMedia.fromJson(Json json) => _$TrendMediaFromJson(json);
}