import 'package:movies_app/app/data/services/remote/popular_service.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/domain/repositories/popular_repository.dart';

class PopularRepositoryImpl implements PopularRepository {
  final PopularService _popularService;

  PopularRepositoryImpl(this._popularService);
  @override
  Future<Either<HttpRequestFailure, List<TrendMedia>>> getMoviesAndSeries() {
    return _popularService.getPopularMovies();
  }
  
}