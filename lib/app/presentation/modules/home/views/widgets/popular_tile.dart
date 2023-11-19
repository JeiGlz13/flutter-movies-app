import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/presentation/global/utils/get_image_url.dart';

class PopularTile extends StatelessWidget {
  final TrendMedia movie;
  final double width;
  const PopularTile({super.key, required this.movie, required this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: width,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                getImageUrl(movie.posterPath),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: Chip(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 1,
                label: Text(movie.voteAverage.toStringAsFixed(1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}