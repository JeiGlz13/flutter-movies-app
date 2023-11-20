import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/domain/repositories/popular_repository.dart';
import 'package:movies_app/app/presentation/modules/home/views/widgets/popular_tile.dart';
import 'package:movies_app/app/presentation/modules/home/views/widgets/popular_type.dart';

import 'package:provider/provider.dart';

class PopularList extends StatefulWidget {
  const PopularList({super.key});

  @override
  State<PopularList> createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
  late Future<Either<HttpRequestFailure, List<TrendMedia>>> _future;
  TrendType _type = TrendType.movie;

  PopularRepository get _popularRepository => context.read();

  @override
  void initState() {
    super.initState();
    _future = _popularRepository.getPopularMoviesOrSeries(_type);
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PopularType(
          type: _type,
          onChange: (value) {
            setState(() {
              _type = value;
              _future = _popularRepository.getPopularMoviesOrSeries(_type);
            });
          },
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 16/9,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxHeight * 0.75;
              return Center(
                child: FutureBuilder<Either<HttpRequestFailure, List<TrendMedia>>>(
                  key: ValueKey(_future),
                  future: _future,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    return snapshot.data!.when(
                      error: (value) => Text(value.toString()),
                      success: (list) {
                        return ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 10);
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          scrollDirection: Axis.horizontal,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            final movie = list[index];
                            return PopularTile(movie: movie, width: width);
                          },
                        );
                      },
                    );
                  },
                ),
              );
            },
          )
        ),
      ],
    );
  }
}