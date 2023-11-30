import 'package:flutter/material.dart';
import 'package:movies_app/app/presentation/global/widgets/request_failed.dart';
import 'package:movies_app/app/presentation/modules/home/controllers/home_controller.dart';
import 'package:movies_app/app/presentation/modules/home/controllers/state/home_state.dart';
import 'package:movies_app/app/presentation/modules/home/views/widgets/movies_series/popular_tile.dart';
import 'package:movies_app/app/presentation/modules/home/views/widgets/movies_series/popular_type.dart';

import 'package:provider/provider.dart';

class PopularList extends StatelessWidget {
  const PopularList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = context.watch();
    final MoviesState state = homeController.state.moviesState;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PopularType(
          type: state.type,
          onChange: homeController.onTypeChanged,
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 16/9,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxHeight * 0.75;
              return Center(
                child: state.when(
                  loading: (type) => const CircularProgressIndicator(),
                  failed: (type) => RequestFailed(onRetry: () {
                    homeController.loadMovies(
                      moviesState: MoviesState.loading(type)
                    );
                  }),
                  loaded: (moviesAndSeries, type) => ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: moviesAndSeries.length,
                    itemBuilder: (context, index) {
                      final movie = moviesAndSeries[index];
                      return PopularTile(movie: movie, width: width);
                    },
                  ),
                )
              );
            },
          )
        ),
      ],
    );
  }
}
