import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:movies_app/app/domain/either.dart';

part 'failure.dart';
part 'parse_response_body.dart';
class Http {
  final String _baseUrl;
  final String _token;
  final Client _client;

  Http(this._client, {required String baseUrl, required String token}) : _baseUrl = baseUrl, _token = token;

  Future<Either<HttpFailure, T>> request<T>(
    String path,
    {
      required T Function(dynamic responseBody) onSuccess,
      HttpMethod method = HttpMethod.get,
      Map<String, String> headers = const {},
      Map<String, String> queryParameters = const {},
      Map<String, dynamic> body = const {},
    }
  ) async {
    Map<String, dynamic> logs = {};
    StackTrace? stackTrace;
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

      logs = {
        'url': url.toString(),
        'method': method.name,
        'body': body,
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
      logs = {
        ...logs,
        'statusCode': statusCode,
        'response': _parseResponseBody(response.body),
      };
      if (statusCode >= 200 && statusCode < 300) {
        return Either.success(value: onSuccess(_parseResponseBody(response.body)));
      }

      return Either.error(
        value: HttpFailure(
          statusCode: statusCode,
          data: _parseResponseBody(response.body),
        ),
      );
    } catch (e, s) {
      stackTrace = s;
      logs = {
        ...logs,
        'exception': e.runtimeType.toString(),
      };
      if (e is SocketException || e is ClientException) {
        logs = {
          ...logs,
          'exception': 'NetworkException',
        };
        return Either.error(
          value: HttpFailure(
            exception: NetworkException()
          ),
        );
      }

      return Either.error(value: HttpFailure(exception: e));
    } finally {
      final convertedLogs = const JsonEncoder.withIndent(' ').convert(logs);
      log('''
---------------------------------------------------
                    LOG
$convertedLogs
--------------------------------------------------
''',
  stackTrace: stackTrace,
);
    }
  }
}

class NetworkException {

}

enum HttpMethod {
  get, post, put, patch, delete,
}
