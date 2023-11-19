part of 'http.dart';

class HttpFailure {
  final int? statusCode;
  final Object? exception;

  final Object? data;

  HttpFailure({this.statusCode, this.exception, this.data});
}