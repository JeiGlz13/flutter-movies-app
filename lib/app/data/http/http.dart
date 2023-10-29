import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:movies_app/app/domain/either.dart';

class Http {
  final String _baseUrl;
  final String _token;
  final Client _client;

  Http(this._client, {required String baseUrl, required String token}) : _baseUrl = baseUrl, _token = token;

  Future<Either<HttpFailure, T>> request<T>(
    String path,
    {
      required T Function(String responseBody) onSuccess,
      HttpMethod method = HttpMethod.get,
      Map<String, String> headers = const {},
      Map<String, String> queryParameters = const {},
      Map<String, dynamic> body = const {},
    }
  ) async {
    try {
      late final Response response;
      Uri url = Uri.parse(
        path.startsWith('http') ? path : '$_baseUrl$path'
      );
  
      if (queryParameters.isNotEmpty) {
        url = url.replace(queryParameters: queryParameters);
      }
  
      headers = {
        'Authorization': _token,
        'content-type': 'application/json',
        ...headers,
      };
  
      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url, headers: headers);
          break;
        case HttpMethod.post:
          response = await _client.post(url, headers: headers, body: jsonEncode(body));
          break;
        case HttpMethod.put:
          response = await _client.put(url, headers: headers, body: jsonEncode(body));
          break;
        case HttpMethod.patch:
          response = await _client.patch(url, headers: headers, body: jsonEncode(body));
          break;
        case HttpMethod.delete:
          response = await _client.delete(url, headers: headers, body: jsonEncode(body));
          break;
      }

      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 300) {
        return Either.right(onSuccess(response.body));
      }

      return Either.left(
        HttpFailure(statusCode: statusCode),
      );
    } catch (e) {
      print(e);
      if (e is SocketException || e is ClientException) {
        return Either.left(
          HttpFailure(
            exception: NetworkException()
          ),
        );
      }

      return Either.left(HttpFailure(exception: e));
    }
  }
}

class HttpFailure {
  final int? statusCode;
  final Object? exception;

  HttpFailure({this.statusCode, this.exception});
}

class NetworkException {

}

enum HttpMethod {
  get, post, put, patch, delete,
}