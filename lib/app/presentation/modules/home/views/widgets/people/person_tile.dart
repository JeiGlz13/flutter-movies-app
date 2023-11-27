import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/models/people/people.dart';
import 'package:movies_app/app/presentation/global/utils/get_image_url.dart';
import 'package:movies_app/app/presentation/modules/home/views/widgets/movies_series/popular_tile.dart';

class PersonTile extends StatelessWidget {
  final People person;
  final double width;
  const PersonTile({super.key, required this.person, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned.fill(
                child: ExtendedImage.network(
                  getImageUrl(person.profilePath),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(20).copyWith(bottom: 40),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                        Colors.black,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        person.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if(person.name != person.originalName)
                        Text(
                          person.originalName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      if(person.knownFor.isNotEmpty)
                        SizedBox(
                          height: 130,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(width: 10),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final media = person.knownFor[index];
                              return PopularTile(
                                movie: media,
                                width: 130 * 0.75,
                                showData: false,
                              );
                            },
                            itemCount: person.knownFor.length,
                          ),
                        )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}