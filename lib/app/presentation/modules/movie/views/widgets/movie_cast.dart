import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/models/people/people.dart';
import 'package:movies_app/app/domain/repositories/movies_repository.dart';
import 'package:movies_app/app/presentation/global/utils/get_image_url.dart';
import 'package:movies_app/app/presentation/global/widgets/request_failed.dart';
import 'package:provider/provider.dart';

class MovieCast extends StatefulWidget {
  final int movieId;
  const MovieCast({super.key, required this.movieId});

  @override
  State<MovieCast> createState() => _MovieCastState();
}

class _MovieCastState extends State<MovieCast> {
  late Future<Either<HttpRequestFailure, List<People>>> _future;

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  void _initFuture(){
    _future = context.read<MoviesRepository>().getCastByMovie(widget.movieId);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<HttpRequestFailure, List<People>>>(
      key: ValueKey(_future),
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        return snapshot.data!.when(
          error: (value) => RequestFailed(onRetry: () {
            setState(() {
              _initFuture();
            });
          }),
          success: (cast) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0).copyWith(top: 0),
                child: const Text(
                  'Cast',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 140,
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 15),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final person = cast[index];
                    return Column(
                      children: [
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final size = constraints.maxHeight;
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(size / 2),
                                child: ExtendedImage.network(
                                  getImageUrl(person.profilePath),
                                  height: size,
                                  width: size,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(person.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 15),
                  itemCount: cast.length,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}