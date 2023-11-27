import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/http_request/http_request_failure.dart';
import 'package:movies_app/app/domain/models/people/people.dart';
import 'package:movies_app/app/domain/repositories/popular_repository.dart';
import 'package:movies_app/app/presentation/global/utils/get_image_url.dart';
import 'package:movies_app/app/presentation/global/widgets/request_failed.dart';
import 'package:movies_app/app/presentation/modules/home/views/widgets/people/person_tile.dart';
import 'package:provider/provider.dart';

typedef EitherListPeople = Either<HttpRequestFailure, List<People>>;

class PopularPeople extends StatefulWidget {
  const PopularPeople({super.key});

  @override
  State<PopularPeople> createState() => _PopularPeopleState();
}

class _PopularPeopleState extends State<PopularPeople> {
  late Future<EitherListPeople> _future;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    _future = context.read<PopularRepository>().getPopularPeople();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: FutureBuilder<EitherListPeople>(
        key: ValueKey(_future),
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
    
          return snapshot.data!.when(
            error: (value) => RequestFailed(
              onRetry: () {
                setState(() {
                 _future = context.read<PopularRepository>().getPopularPeople();
                });
              }, 
            ),
            success: (people) => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    final person = people[index];
                    return PersonTile(person: person, width: width);
                  },
                  itemCount: people.length,
                ),
                Positioned(
                  bottom: 30,
                  child: AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      final int currentCard = _pageController.page?.toInt() ?? 0;
                      return Row(
                        children: List.generate(
                          people.length,
                          (index) => Icon(
                            Icons.circle,
                            color: (currentCard == index) ? Colors.blue : Colors.white30,
                            size: 15,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}