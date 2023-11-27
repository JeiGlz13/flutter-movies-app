import 'package:movies_app/app/domain/repositories/popular_repository.dart';
import 'package:movies_app/app/presentation/global/state_notifier.dart';

class HomeController extends StateNotifier {
  final PopularRepository popularRepository;
  HomeController(
    super.state,
    { required this.popularRepository }
  );

  Future<void> init() async {
    final result = await popularRepository.getPopularMoviesOrSeries(
      state.type,
    );

    result.when(
      error: (value) {
        state = state.copyWith(
          isLoading: false,
          moviesAndSeries: null,
        ); 
      },
      success: (movies) {
        state = state.copyWith(
          isLoading: false,
          moviesAndSeries: movies,
        );
      },
    );
  }
}