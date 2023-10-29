import 'dart:convert';

import 'package:movies_app/app/data/http/http.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/sign_in_fail.dart';

class AuthenticationService {
  final Http _http;

  AuthenticationService(this._http);

  Either<SignInFail, String> _handleFailure(HttpFailure httpFailure) {
    if (httpFailure.statusCode != null) {
      switch (httpFailure.statusCode) {
        case 401:
          return Either.left(SignInFail.unauthorized);      
        case 404:
          return Either.left(SignInFail.notFound);
        default:
          return Either.left(SignInFail.unknown);
      }
    }

    if (httpFailure.exception is NetworkException) {
      return Either.left(SignInFail.network);
    }

    return Either.left(SignInFail.unknown);
  }

  Future<Either<SignInFail, String?>> createRequestToken() async {
      final result = await _http.request(
        '/authentication/token/new',
        onSuccess: (responseBody) {
          final json = Map<String, dynamic>.from(jsonDecode(responseBody));
          return json['request_token'] as String;
        },
      );

      return result.when(
        _handleFailure,
        (token) => Either.right(token),
      );
  }

  Future<Either<SignInFail, String>> createSessionWithLogin({
    required String userName,
    required String password,
    required String requestToken,
  }) async {
    final result = await _http.request(
      '/authentication/token/validate_with_login',
      method: HttpMethod.post,
      onSuccess: (responseBody) {
        final json = Map<String, dynamic>.from(jsonDecode(responseBody));
        return json['request_token'] as String;
      },
      body: {
        'username': userName,
        'password': password,
        'request_token': requestToken,
      }
    );

    return result.when(
      _handleFailure,
      (requestToken) => Either.right(requestToken),
    );
  }

  Future<Either<SignInFail, String>> createSession(String requestToken) async {
    final result = await _http.request(
      '/authentication/session/new',
      onSuccess: (responseBody) {
        final json = Map<String, dynamic>.from(jsonDecode(responseBody));
        return json['session_id'] as String;
      },
      method: HttpMethod.post,
      body: {
       'request_token': requestToken,
      }
    );

    return result.when(
      _handleFailure,
      (sessionId) => Either.right(sessionId),
    );
  }
}
