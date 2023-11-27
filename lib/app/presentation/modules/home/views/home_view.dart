import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/repositories/authentication_repository.dart';
import 'package:movies_app/app/domain/repositories/popular_repository.dart';
import 'package:movies_app/app/presentation/global/controllers/session_controller.dart';
import 'package:movies_app/app/presentation/modules/home/controllers/home_controller.dart';
import 'package:movies_app/app/presentation/modules/home/controllers/state/home_state.dart';
import 'package:movies_app/app/presentation/modules/home/views/widgets/movies_series/popular_list.dart';
import 'package:movies_app/app/presentation/modules/home/views/widgets/people/popular_people.dart';
import 'package:movies_app/app/presentation/routes/routes.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) {
        final controller = HomeController(
        HomeState(isLoading: true),
          popularRepository: context.read<PopularRepository>(),
        );
        controller.init();
        return controller;
      },
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return RefreshIndicator(
                onRefresh: () async {
    
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: constraints.maxHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PopularList(),
                        const SizedBox(height: 20),
                        const PopularPeople(),
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}