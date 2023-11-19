import 'package:movies_app/app/data/http/http.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/sign_in/sign_in_failure.dart';

class AuthenticationService {
  final Http _http;

  AuthenticationService(this._http);

  Either<SignInFailure, String> _handleFailure(HttpFailure httpFailure) {
    if (httpFailure.statusCode != null) {
      switch (httpFailure.statusCode) {
        case 401:
          if((httpFailure.data is Map) && ((httpFailure.data as Map)['status_code'] == 32)) {
            return Either.error(value: SignInFailure.notVerified());
          }
          return Either.error(value: SignInFailure.unauthorized());      
        case 404:
          return Either.error(value: SignInFailure.notFound());
        default:
          return Either.error(value: SignInFailure.unknown());
      }
    }

    if (httpFailure.exception is NetworkException) {
      return Either.error(value: SignInFailure.network());
    }

    return Either.error(value: SignInFailure.unknown());
  }

  Future<Either<SignInFailure, String?>> createRequestToken() async {
      final result = await _http.request(
        '/authentication/token/new',
        onSuccess: (responseBody) {
          final json = responseBody as Map;
          return json['request_token'] as String;
        },
      );

      return result.when(
        error: _handleFailure,
        success: (token) => Either.success(value: token),
      );
  }

  Future<Either<SignInFailure, String>> createSessionWithLogin({
    required String userName,
    required String password,
    required String requestToken,
  }) async {
    final result = await _http.request(
      '/authentication/token/validate_with_login',
      method: HttpMethod.post,
      onSuccess: (responseBody) {
        final json = responseBody as Map;
        return json['request_token'] as String;
      },
      body: {
        'username': userName,
        'password': password,
        'request_token': requestToken,
      }
    );

    return result.when(
      error: _handleFailure,
      success:  (requestToken) => Either.success(value: requestToken),
    );
  }

  Future<Either<SignInFailure, String>> createSession(String requestToken) async {
    final result = await _http.request(
      '/authentication/session/new',
      onSuccess: (responseBody) {
        final json = responseBody as Map;
        return json['session_id'] as String;
      },
      method: HttpMethod.post,
      body: {
       'request_token': requestToken,
      }
    );

    return result.when(
      error: _handleFailure,
       success: (sessionId) => Either.success(value: sessionId),
    );
  }
}
