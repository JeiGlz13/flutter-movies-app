import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/models/people/people.dart';
import 'package:movies_app/app/domain/repositories/popular_repository.dart';
import 'package:provider/provider.dart';

typedef EitherListPeople = Either<HttpRequestFailure, List<People>>;

class PopularPeople extends StatefulWidget {
  const PopularPeople({super.key});

  @override
  State<PopularPeople> createState() => _PopularPeopleState();
}

class _PopularPeopleState extends State<PopularPeople> {
  late Future<EitherListPeople> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<PopularRepository>().getPopularPeople();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EitherListPeople>(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return snapshot.data!.when(
          error: (value) => const Text('Error'),
          success: (people) => Text('Performers'),
        );
      },
    );
  }
}