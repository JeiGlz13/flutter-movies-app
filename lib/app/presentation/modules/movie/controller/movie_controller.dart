import 'package:movies_app/app/domain/repositories/movies_repository.dart';
import 'package:movies_app/app/presentation/global/state_notifier.dart';
import 'package:movies_app/app/presentation/modules/movie/controller/state/movie_state.dart';

class MovieController extends StateNotifier<MovieState> {
  final MoviesRepository moviesRepository;
  final int movieId;

  MovieController(
    super.state,
    {
      required this.moviesRepository,
      required this.movieId,
    }
  );

  Future<void> init() async {
    final result = await moviesRepository.getMovieById(movieId);
    state = result.when(
      error: (value) => MovieState.failed(),
      success: (value) => MovieState.loaded(value),
    );
  }
}