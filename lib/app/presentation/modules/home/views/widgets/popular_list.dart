import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/domain/repositories/popular_repository.dart';
import 'package:movies_app/app/presentation/modules/home/views/widgets/popular_tile.dart';

import 'package:provider/provider.dart';

class PopularList extends StatefulWidget {
  const PopularList({super.key});

  @override
  State<PopularList> createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
  late final Future<Either<HttpRequestFailure, List<TrendMedia>>> _future;

  @override
  void initState() {
    super.initState();
    final PopularRepository popularRepository = context.read();
    _future = popularRepository.getMoviesAndSeries();
  }
  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15, top: 15),
          child: Text(
            'Trending movies',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 16/9,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxHeight * 0.75;
              return Center(
                child: FutureBuilder<Either<HttpRequestFailure, List<TrendMedia>>>(
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
                            return SizedBox(width: 10);
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