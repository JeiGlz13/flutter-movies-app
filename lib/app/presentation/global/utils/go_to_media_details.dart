import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/presentation/modules/movie/views/movie_view.dart';

Future<void> goToMediaDetails(
  BuildContext context,
  int mediaId,
  TrendType? type
) async {
  if (type == TrendType.movie) {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieView(movieId: mediaId),
      ),
    );
  }
}