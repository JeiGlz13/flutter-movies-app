import 'package:movies_app/app/data/services/remote/movies_service.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/models/movie/movie.dart';
import 'package:movies_app/app/domain/models/people/people.dart';
import 'package:movies_app/app/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesService _moviesService;

  MoviesRepositoryImpl({required MoviesService moviesService}) : _moviesService = moviesService;

  @override
  Future<Either<HttpRequestFailure, Movie>> getMovieById(int id) {
    return _moviesService.getMovieById(id);
  }

  @override
  Future<Either<HttpRequestFailure, List<People>>> getCastByMovie(int movieId) {
    return _moviesService.getCastByMovie(movieId);
  }

}