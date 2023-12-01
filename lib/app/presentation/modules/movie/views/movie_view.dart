import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/repositories/movies_repository.dart';
import 'package:movies_app/app/presentation/global/widgets/request_failed.dart';
import 'package:movies_app/app/presentation/modules/movie/controller/movie_controller.dart';
import 'package:movies_app/app/presentation/modules/movie/controller/state/movie_state.dart';
import 'package:movies_app/app/presentation/modules/movie/views/widgets/movie_content.dart';
import 'package:provider/provider.dart';

class MovieView extends StatelessWidget {
  final int movieId;
  const MovieView({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieController(
        MovieState.loading(),
        moviesRepository: context.read<MoviesRepository>(),
        movieId: movieId,
      )..init(),
      builder: (context, child) {
        final MovieController movieController = context.watch();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            actions: movieController.state.map(
              loading: (value) => null,
              failed: (value) => null,
              loaded: (value) => [
                IconButton(
                  onPressed: () {
                    
                  },
                  icon: Icon(Icons.favorite_outline),
                )
              ],
            ),
          ),
          extendBodyBehindAppBar: true,
          body: movieController.state.map(
            loading: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            failed: (_) => RequestFailed(
              onRetry: () => movieController.init(),
            ),
            loaded: (movieState) => MovieContent(
              stateLoaded: movieState,
            ),
          ),
        );
      },
    );
  }
}