import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/models/movie/movie.dart';
import 'package:movies_app/app/presentation/modules/movie/controller/state/movie_state.dart';
import 'package:movies_app/app/presentation/modules/movie/views/widgets/movie_cast.dart';
import 'package:movies_app/app/presentation/modules/movie/views/widgets/movie_header.dart';

class MovieContent extends StatelessWidget {
  final MovieStateLoaded stateLoaded;
  const MovieContent({super.key, required this.stateLoaded});

  @override
  Widget build(BuildContext context) {
    final Movie movie = stateLoaded.movie;
    return SingleChildScrollView(
      child: Column(
        children: [
          MovieHeader(movie: movie),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(movie.overview),
          ),
          MovieCast(movieId: movie.id),
        ],
      ),
    );
  }
}
