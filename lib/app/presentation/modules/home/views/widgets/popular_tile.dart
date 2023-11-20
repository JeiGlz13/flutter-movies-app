import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/presentation/global/utils/get_image_url.dart';

class PopularTile extends StatelessWidget {
  final TrendMedia movie;
  final double width;
  const PopularTile({super.key, required this.movie, required this.width});

  @override
  Widget build(BuildContext context) {
    print(movie);
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
              right: 3,
              top: 3,
              child: Opacity(
                opacity: 0.75,
                child: Chip(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  label: Row(
                    children: [
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.star, color: Colors.amber[600], size: 18)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}