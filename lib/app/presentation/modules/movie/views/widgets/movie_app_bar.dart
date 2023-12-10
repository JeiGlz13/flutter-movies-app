import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/presentation/global/controllers/favorites/favorites_controller.dart';
import 'package:movies_app/app/presentation/global/utils/mark_as_favorite.dart';
import 'package:movies_app/app/presentation/modules/movie/controller/movie_controller.dart';
import 'package:provider/provider.dart';

class MovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieController movieController = context.watch();
    final FavoritesController favoritesController = context.watch();
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      actions: movieController.state.mapOrNull(
        loaded: (movieState) => [
          favoritesController.state.maybeMap(
            orElse: () => const SizedBox(),
            loaded: (favoriteState) => IconButton(
              onPressed: () => markAsFavorite(
                context: context,
                media: movieState.movie.toMedia(),
                type: TrendType.movie,
                mounted: () => movieController.isMounted,
              ),
              icon: Icon(
                (favoriteState.movies.containsKey(movieState.movie.id))
                  ? Icons.favorite
                  : Icons.favorite_outline
              ),
            ),
          )
        ],
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}