import 'package:flutter/material.dart';

class FavoritesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  const FavoritesAppBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text('Favorites'),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.movie),
            ),
            Tab(
              icon: Icon(Icons.tv),
            ),
          ],
        ),
      );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}