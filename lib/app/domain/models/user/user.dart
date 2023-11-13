import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies_app/app/domain/typedefs.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    required int id,
    required String username,
    required String name,

    @JsonKey(fromJson: avatarFromJson, name: 'avatar')
    String? avatarPath,
  }) = _User;

  String getFormatted() {
    return '$username $id';
  }

  factory User.fromJson(Json json) => _$UserFromJson(json);
}

String? avatarFromJson(Json json) {
  final avatarPath = json['tmdb']?['avatar_path'] as String?;
  return avatarPath;
}