import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/models/people/people.dart';
import 'package:movies_app/app/presentation/global/utils/get_image_url.dart';
import 'package:movies_app/app/presentation/modules/home/views/widgets/movies_series/popular_tile.dart';

class PersonTile extends StatefulWidget {
  final People person;
  final double width;
  const PersonTile({super.key, required this.person, required this.width});

  @override
  State<PersonTile> createState() => _PersonTileState();
}

class _PersonTileState extends State<PersonTile> {
  bool showKnownFor = false;
  final double maxHeight = 180;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned.fill(
                child: ExtendedImage.network(
                  getImageUrl(widget.person.profilePath),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    if (details.delta.dy < -1) {
                      setState(() {
                        showKnownFor = true;
                      });
                    }
                    if (details.delta.dy > 1) {
                      setState(() {
                        showKnownFor = false;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20).copyWith(bottom: 40),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        end: Alignment.bottomCenter,
                        begin: Alignment.topCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black12,
                          Colors.black38,
                          Colors.black,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.person.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if(widget.person.name != widget.person.originalName)
                          Text(
                            widget.person.originalName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        if(widget.person.knownFor.isNotEmpty && showKnownFor)
                          SizedBox(
                            height: maxHeight,
                            child: ListView.separated(
                              separatorBuilder: (context, index) => const SizedBox(width: 15),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final media = widget.person.knownFor[index];
                                return PopularTile(
                                  movie: media,
                                  width: maxHeight * 0.75,
                                  showData: false,
                                );
                              },
                              itemCount: widget.person.knownFor.length,
                            ),
                          )
                      ],
                    ),
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