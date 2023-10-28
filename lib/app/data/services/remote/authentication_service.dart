import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/sign_in_fail.dart';

class AuthenticationService {
  final Client _client;
  final _token = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1YzgxYjcwZDE0MGU5Njk3ZWRiOGRmZjQxMDgzMzBiMCIsInN1YiI6IjY1MzMxMGJlMzk1NDlhMDEwYjYxMjFiZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.A2RnzvaACHYKavd_8sJE6M0BPJv5PqkzZLk398cJbgs';
  final _baseUrl = 'https://api.themoviedb.org';

  AuthenticationService({required Client client}) : _client = client;

  Future<String?> createRequestToken() async {
    try {
      final response = await _client.get(
       Uri.parse('$_baseUrl/3/authentication/token/new'),
         headers: Map.from({ 'Authorization': _token }),
       );

     if(response.statusCode == 200) {
       final json = Map<String, dynamic>.from(jsonDecode(response.body));
       return json['request_token'];
     }
  
     return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Either<SignInFail, String>> createSessionWithLogin({
    required String userName,
    required String password,
    required String requestToken,
  }) async {
    try {
      final response = await _client.post(
       Uri.parse('$_baseUrl/3/authentication/token/new'),
        headers: Map.from({
         'Authorization': _token,
         'Content-Type': 'application/json',
         }),
        body: jsonEncode({
         'username': userName,
         'password': password,
         'request_token': requestToken,
        }),
       );

       switch (response.statusCode) {
          case 200:
            final json = Map<String, dynamic>.from(jsonDecode(response.body));
            final requestToken = json['request_token'] as String;
            return Either.right(requestToken);

          case 401:
            return Either.left(SignInFail.unauthorized);
          
          case 404:
            return Either.left(SignInFail.notFound);
          default:
            return Either.left(SignInFail.unknown);
       }
    } catch (e) {
      print(e);
      if (e is SocketException) {
        return Either.left(SignInFail.network);
      }

      return Either.left(SignInFail.unknown);
    }
  }
}