import 'package:movies_app/app/data/http/http.dart';
import 'package:movies_app/app/data/services/local/session_service.dart';
import 'package:movies_app/app/data/services/utils/handle_failure.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/domain/models/user/user.dart';

class AccountService {
  final Http _http;
  final SessionService _sessionService;

  AccountService(this._http, this._sessionService);

  Future<User?> getAccount(String sessionId) async{
    final result = await _http.request(
      '/account/1',
      queryParameters: {
        'session_id': sessionId
      },
      onSuccess: (json) {
        return User.fromJson(json);
      },
    );

    return result.when(
      error: (_) => null,
      success: (user) => user,
    );
  }

  Future<Either<HttpRequestFailure, Map<int, TrendMedia>>> getFavorites(TrendType type) async {
    final sessionId = await _sessionService.sessionId ?? '';
    final accountId = await _sessionService.accountId ?? '';
    final String typeName = (type == TrendType.movie) ? 'movies' : 'tv';
    final result = await _http.request(
      '/account/$accountId/favorite/$typeName',
      queryParameters: {
        'language': 'es-ES',
        'session_id': sessionId,
      },
      onSuccess: (json) {
        final list = json['results'] as List;
        final iterable = list.map((e) {
          final media = TrendMedia.fromJson(e);
          return MapEntry(media.id, media);
        });

        final Map<int, TrendMedia> map = {};
        map.addEntries(iterable);
        return map;
      },
    );

    return result.when(
      error: handleHttpFailure,
      success: (value) => Either.success(value: value),
    );
  }

  Future<Either<HttpRequestFailure, void>> markAsFavorite({
    required int mediaId,
    required TrendType type,
    required bool isFavorite,
  }) async {
    final accountId = await _sessionService.accountId ?? '';
    final sessionId = await _sessionService.sessionId ?? '';
    final result = await _http.request(
      '/account/$accountId/favorite',
      method: HttpMethod.post,
      queryParameters: {
        'session_id': sessionId,
      },
      body: {
        'media_type': type.name,
        'media_id': mediaId,
        'favorite': isFavorite,
      },
      onSuccess: (responseBody) => null,
    );

    return result.when(
      error: handleHttpFailure,
      success: (value) => Either.success(value: null),
    );
  }
}