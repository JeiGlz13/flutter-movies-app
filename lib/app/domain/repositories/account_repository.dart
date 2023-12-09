import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/domain/models/user/user.dart';
abstract class AccountRepository {
  Future<User?> getUserData();
  Future<Either<HttpRequestFailure, Map<int, TrendMedia>>> getFavorites(TrendType type);
    Future<Either<HttpRequestFailure, void>> markAsFavorite({
    required int mediaId,
    required TrendType type,
    required bool isFavorite,
  });
}