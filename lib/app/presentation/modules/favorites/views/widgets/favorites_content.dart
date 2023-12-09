import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/presentation/global/controllers/favorites/state/favorites_state.dart';
import 'package:movies_app/app/presentation/modules/favorites/views/widgets/favorites_list.dart';

class FavoritesContent extends StatelessWidget {
  final FavoritesStateLoaded state;
  final TabController tabController;

  const FavoritesContent({super.key, required this.state, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        FavoritesList(items: state.movies.values.toList(), trendType: TrendType.movie),
        FavoritesList(items: state.series.values.toList(), trendType: TrendType.tv,),
      ]
    );
  }
}
