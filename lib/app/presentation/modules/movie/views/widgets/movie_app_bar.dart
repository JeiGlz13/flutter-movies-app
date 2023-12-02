import 'package:flutter/material.dart';
import 'package:movies_app/app/presentation/modules/movie/controller/movie_controller.dart';
import 'package:provider/provider.dart';

class MovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieController movieController = context.watch();
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      actions: movieController.state.mapOrNull(
        loaded: (value) => [
          IconButton(
            onPressed: () {
              
            },
            icon: Icon(Icons.favorite_outline),
          )
        ],
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}