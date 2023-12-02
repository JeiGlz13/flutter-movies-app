import 'package:movies_app/app/data/http/http.dart';
import 'package:movies_app/app/data/services/utils/handle_failure.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/models/movie/movie.dart';
import 'package:movies_app/app/domain/models/people/people.dart';

class MoviesService {
  final Http _http;

  MoviesService({required Http http}) : _http = http;

  Future<Either<HttpRequestFailure, Movie>> getMovieById(int id) async {
    final result = await _http.request(
      '/movie/$id',
      queryParameters: {
        'language': 'es-ES',
      },
      onSuccess: (responseBody) {
        return Movie.fromJson(responseBody);
      },
    );

    return result.when(
      error: handleHttpFailure,
      success: (value) => Either.success(value: value),
    );
  }

  Future<Either<HttpRequestFailure, List<People>>> getCastByMovie(int movieId) async {
    final result = await _http.request(
      '/movie/$movieId/credits',
      queryParameters: {
        'language': 'es-ES',
      },
      onSuccess: (responseBody) {
        final cast = responseBody['cast'] as List;
        return cast
          .where((element) => (element['profile_path'] != null) && (element['known_for_department'] == 'Acting'))
          .map((person) => People.fromJson({
            ...person,
            'known_for': [],
          })).toList();
      },
    );

    return result.when(
      error: handleHttpFailure,
      success: (value) => Either.success(value: value),
    );
  }
}