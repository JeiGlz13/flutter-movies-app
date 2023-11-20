import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies_app/app/domain/typedefs.dart';

part 'trend_media.freezed.dart';
part 'trend_media.g.dart';

@freezed
class TrendMedia with _$TrendMedia {
  factory TrendMedia({
    required int id,
    required String overview,

    @JsonKey(readValue: readTitleValue)
    required String title,
    @JsonKey(readValue: readOriginalTitleValue)
    required String originalTitle,
    @JsonKey(readValue: readReleaseDateValue)
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

Object? readTitleValue(Map map, String _) {
  return map['title'] ?? map['name'];
}
Object? readOriginalTitleValue(Map map, String _) {
  return map['original_title'] ?? map['original_name'];
}
Object? readReleaseDateValue(Map map, String _) {
  return map['release_date'] ?? map['first_air_date'];
}

List<TrendMedia> getMediaListFromJson(List list) {
  return list
    .where((element) => element['poster_path'] != null)
    .map((element) => TrendMedia.fromJson(element))
    .toList();
}