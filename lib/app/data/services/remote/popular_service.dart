import 'package:movies_app/app/data/http/http.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/domain/typedefs.dart';

class PopularService {
  final Http _http;

  PopularService(this._http);

  Future<Either<HttpFailure, List<TrendMedia>>> getPopularMovies() async {
    final result = await _http.request(
      '/movie/popular',
      queryParameters: {
        'language': 'es-ES',
        'page': '1',
      },
      onSuccess: (json) {
        final list = json['result'] as List<Json>;
        final List<TrendMedia> trendMedia = list.map((item) => TrendMedia.fromJson(item)).toList();
        return trendMedia;
      }
    );

    return result;
  }
}