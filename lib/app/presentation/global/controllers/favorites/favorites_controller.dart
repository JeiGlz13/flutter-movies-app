import 'package:movies_app/app/data/services/remote/account_service.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/presentation/global/controllers/favorites/state/favorites_state.dart';
import 'package:movies_app/app/presentation/global/state_notifier.dart';

class FavoritesController extends StateNotifier<FavoritesState> {
  final AccountService accountService;
  FavoritesController(super.state, { required this.accountService });

  Future<void> init() async {
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
}