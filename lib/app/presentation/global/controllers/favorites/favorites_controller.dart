import 'package:movies_app/app/data/services/remote/account_service.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/presentation/global/controllers/favorites/state/favorites_state.dart';
import 'package:movies_app/app/presentation/global/state_notifier.dart';

class FavoritesController extends StateNotifier<FavoritesState> {
  final AccountService accountService;
  FavoritesController(super.state, { required this.accountService });

  Future<void> init() async {
    state = FavoritesState.loading();
    final moviesResult = await accountService.getFavorites(TrendType.movie);

    state = await moviesResult.when(
      error: (value) async => FavoritesState.failed(),
      success: (movies) async {
        final tvResult = await accountService.getFavorites(TrendType.tv);
        return tvResult.when(
          error: (value) => FavoritesState.failed(),
          success: (series) => FavoritesState.loaded(
            movies: movies,
            series: series,
          ),
        );
      },
    );
  }

  Future<Either<HttpRequestFailure, void>> markAsFavorite(TrendMedia media, TrendType type) async {
    assert(state is FavoritesStateLoaded);
    final loadedState = state as FavoritesStateLoaded;

    final isMovie = (type == TrendType.movie);
    final map = isMovie
      ? { ...loadedState.movies }
      : { ...loadedState.series };

    final isFavorite = !(map.keys.contains(media.id));
    final result = await accountService.markAsFavorite(
      mediaId: media.id,
      type: type,
      isFavorite: isFavorite,
    );

    result.whenOrNull(
      success: (value) {
        if (isFavorite) {
          map[media.id] = media;    
        } else {
          map.remove(media.id);
        }

        state = isMovie
          ? loadedState.copyWith(movies: map)
          : loadedState.copyWith(series: map);
      },
    );

    return result;
  }
}