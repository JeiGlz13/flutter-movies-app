import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';

abstract class PopularRepository {
  Future<Either<HttpRequestFailure, List<TrendMedia>>> getMoviesAndSeries();
}