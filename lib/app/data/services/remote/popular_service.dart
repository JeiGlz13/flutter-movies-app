import 'package:movies_app/app/data/http/http.dart';
import 'package:movies_app/app/data/services/utils/handle_failure.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/domain/models/people/people.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/domain/typedefs.dart';

class PopularService {
  final Http _http;

  PopularService(this._http);

  Future<Either<HttpRequestFailure, List<TrendMedia>>> getPopularMoviesOrSeries(TrendType type) async {
    final result = await _http.request(
      '/trending/${type.name}/week',
      queryParameters: {
        'language': 'es-ES',
        'page': '1',
      },
      onSuccess: (json) {
        final list = List<Json>.from(json['results']);
        final List<TrendMedia> trendMedia = getMediaListFromJson(list);
        return trendMedia;
      }
    );

    return result.when(
      error: handleHttpFailure,
      success: (media) => Either.success(value: media),
    );
  }
  Future<Either<HttpRequestFailure, List<People>>> getPopularPeople() async {
    final result = await _http.request(
      '/trending/person/week',
      queryParameters: {
        'language': 'es-ES',
      },
      onSuccess: (json) {
        final list = List<Json>.from(json['results']);
        final List<People> trendPeople = list
          .where((element) => element['profile_path'] != null)
          .map((element) => People.fromJson(element))
          .take(10)
          .toList();
        return trendPeople;
      }
    );

    return result.when(
      error: handleHttpFailure,
      success: (media) => Either.success(value: media),
    );
  }
}