import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  // @JsonKey(name: 'userId')
  final int id;
  final String username;
  final String name;
  final String? avatarPath;

  const User({
    required this.id, required this.username, required this.name, required this.avatarPath,
  });

  // factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  factory User.fromJson(Map<String, dynamic> json) {
    final avatarPath = json['avatar']?['tmdb']?['avatar_path'] as String?;
    return User(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      avatarPath: avatarPath ?? '',
    );

    // https://image.tmdb.org/t/p/w500
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [id, username, name];
}