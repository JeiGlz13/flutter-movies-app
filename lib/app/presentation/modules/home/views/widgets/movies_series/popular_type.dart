import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';

class PopularType extends StatelessWidget {
  final TrendType type;
  final void Function(TrendType) onChange;
  const PopularType({super.key, required this.type, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Trending',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Material(
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<TrendType>(
                  value: type,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(
                      value: TrendType.movie,
                      child: Text('Movies'), 
                    ),
                    DropdownMenuItem(
                      value: TrendType.tv,
                      child: Text('TV Series'), 
                    ),
                  ],
                  onChanged: (value) {
                      if ((value != null) && (type != value)) {
                        onChange(value);
                      }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}