import 'package:movies_app/app/data/http/http.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';

Either<HttpRequestFailure, T> handleHttpFailure<T>(HttpFailure httpFailure) {
  final statusCode = httpFailure.statusCode;
  HttpRequestFailure httpRequestFailure;
  switch (statusCode) {
    case 404:
      httpRequestFailure = HttpRequestFailure.notFound();
    case 401:
      httpRequestFailure = HttpRequestFailure.unauthorized();
    default:
      if(httpFailure.exception is NetworkException) {
        httpRequestFailure = HttpRequestFailure.network();
      }
      httpRequestFailure = HttpRequestFailure.unknown();
  }

  return Either.error(value: httpRequestFailure);
}