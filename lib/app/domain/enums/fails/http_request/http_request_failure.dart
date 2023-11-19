import 'package:freezed_annotation/freezed_annotation.dart';

part 'http_request_failure.freezed.dart';

@freezed
class HttpRequestFailure with _$HttpRequestFailure {

  factory HttpRequestFailure.notFound() = HttpRequestNotFound;
  factory HttpRequestFailure.network() = HttpRequestNetwork;
  factory HttpRequestFailure.unauthorized() = HttpRequestUnauthorized;
  factory HttpRequestFailure.unknown() = HttpRequestUnknown;
}