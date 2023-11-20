import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/domain/typedefs.dart';

part 'people.freezed.dart';
part 'people.g.dart';

@freezed
class People with _$People {
  factory People({
    required int id,
    required String name,
    required double popularity,

    @JsonKey(name: 'original_name')
    required String originalName,
    @JsonKey(name: 'profile_path')
    required String profilePath,
    @JsonKey(name: 'known_for', fromJson: getMediaListFromJson)
    required List<TrendMedia> knownFor,
  }) = _People;

  factory People.fromJson(Json json) => _$PeopleFromJson(json);
}

