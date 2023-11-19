import 'package:movies_app/app/data/http/http.dart';
import 'package:movies_app/app/data/services/utils/handle_failure.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/domain/typedefs.dart';

class PopularService {
  final Http _http;

  PopularService(this._http);

  Future<Either<HttpRequestFailure, List<TrendMedia>>> getPopularMovies() async {
    final result = await _http.request(
      '/movie/popular',
      queryParameters: {
        'language': 'es-ES',
        'page': '1',
      },
      onSuccess: (json) {
        final list = List<Json>.from(json['results']);
        final List<TrendMedia> trendMedia = list
          .where((media) => media['title'] != null)
          .map((item) => TrendMedia.fromJson(item)).toList();
        return trendMedia;
      }
    );

    return result.when(
      error: handleHttpFailure,
      success: (media) => Either.success(value: media),
    );
  }
}