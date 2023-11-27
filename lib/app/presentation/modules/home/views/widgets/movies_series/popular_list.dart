import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/domain/repositories/popular_repository.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PopularType(
          type: homeController.state.type,
          onChange: (p0) {
            
          },
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 16/9,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxHeight * 0.75;
              return Center(
                child: homeController.state.isLoading
                  ? const CircularProgressIndicator()
                  : homeController.state.moviesAndSeries == null
                    ? RequestFailed(onRetry: () {
                      
                    })
                    : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 10);
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          scrollDirection: Axis.horizontal,
                          itemCount: homeController.state.moviesAndSeries.length,
                          itemBuilder: (context, index) {
                            final movie = homeController.state.moviesAndSeries[index];
                            return PopularTile(movie: movie, width: width);
                          },
                        ),
              );
            },
          )
        ),
      ],
    );;
  }
}
