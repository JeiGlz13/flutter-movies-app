import 'package:flutter/material.dart';
import 'package:movies_app/app/data/services/repositories_implementation/connectivity_repository_impl.dart';
import 'package:movies_app/app/domain/repositories/connectivity_repository.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    ConnectivityRepository connectivityRepository = ConnectivityRepositoryImpl();
    final bool hasInternet = await connectivityRepository.hasInternet;

    if (hasInternet) {
      
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 75,
          width: 75,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}