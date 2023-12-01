import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/models/movie/movie.dart';
import 'package:movies_app/app/presentation/global/utils/get_image_url.dart';
import 'package:movies_app/app/presentation/modules/movie/controller/state/movie_state.dart';

class MovieContent extends StatelessWidget {
  final MovieStateLoaded stateLoaded;
  const MovieContent({super.key, required this.stateLoaded});

  @override
  Widget build(BuildContext context) {
    final Movie movie = stateLoaded.movie;
    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16/13,
            child: ExtendedImage.network(
              getImageUrl(movie.backdropPath, imageQuality: ImageQuality.original),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}