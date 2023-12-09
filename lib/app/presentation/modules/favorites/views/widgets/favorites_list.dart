import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/presentation/global/utils/get_image_url.dart';
import 'package:movies_app/app/presentation/global/utils/go_to_media_details.dart';
import 'package:movies_app/app/presentation/modules/movie/views/movie_view.dart';

class FavoritesList extends StatefulWidget {
  final List<TrendMedia> items;
  final TrendType trendType;

  const FavoritesList({super.key, required this.items, required this.trendType});

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return MaterialButton(
          onPressed: () => goToMediaDetails(context, item.id, widget.trendType),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ExtendedImage.network(
                  getImageUrl(item.posterPath),
                  width: 90,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      item.overview,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
      itemCount: widget.items.length,
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}