import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/presentation/global/utils/get_image_url.dart';
import 'package:movies_app/app/presentation/modules/movie/views/movie_view.dart';

class PopularTile extends StatelessWidget {
  final TrendMedia movie;
  final double width;
  final bool showData;
  final TrendType? type;
  const PopularTile({
    super.key, required this.movie, required this.width, this.showData = true, this.type,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (type == TrendType.movie) {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieView(movieId: movie.id),
            ),
          );
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: width,
          child: Stack(
            children: [
              Positioned.fill(
                child: ExtendedImage.network(
                  getImageUrl(movie.posterPath),
                  fit: BoxFit.cover,
                  loadStateChanged: (state) {
                    if (state.extendedImageLoadState == LoadState.loading) {
                      return Container(
                        color: Colors.black12,
                      );
                    }
    
                    return state.completedWidget;
                  },
                ),
              ),
              if(showData)
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
      ),
    );
  }
}