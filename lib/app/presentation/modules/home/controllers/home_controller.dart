import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/domain/repositories/popular_repository.dart';
import 'package:movies_app/app/presentation/global/state_notifier.dart';
import 'package:movies_app/app/presentation/modules/home/controllers/state/home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  final PopularRepository popularRepository;
  HomeController(
    super.state,
    { required this.popularRepository }
  );

  Future<void> init() async {
    await loadMovies();
    await loadPeople();
  }

  void onTypeChanged(TrendType type) {
    if (type != state.moviesState.type) {
      state = state.copyWith(
        moviesState: state.moviesState.copyWith(type: type)
      );

      loadMovies();
    }
  }

  Future<void> loadPeople({ PeopleState? peopleState }) async {
    if (peopleState != null) {
      state = state.copyWith(peopleState: peopleState);
    }
    final peopleResult = await popularRepository.getPopularPeople();
    state = peopleResult.when(
      error: (value) => state.copyWith(
        peopleState: const PeopleState.failed(),
      ),
      success: (value) => state.copyWith(
        peopleState: PeopleState.loaded(people: value),
      ),
    );
  }

  Future<void> loadMovies({ MoviesState? moviesState }) async {
    if (moviesState != null) {
      state = state.copyWith(moviesState: moviesState);
    }
    final moviesResult = await popularRepository.getPopularMoviesOrSeries(
      state.moviesState.type,
    );
    state = moviesResult.when(
      error: (value) => state.copyWith(
        moviesState: MoviesState.failed(state.moviesState.type),
      ),
      success: (value) => state.copyWith(
        moviesState: MoviesState.loaded(moviesAndSeries: value, type: state.moviesState.type),
      ),
    );
  }
}