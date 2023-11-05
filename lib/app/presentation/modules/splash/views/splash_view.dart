import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/repositories/authentication_repository.dart';
import 'package:movies_app/app/domain/repositories/connectivity_repository.dart';
import 'package:movies_app/app/presentation/routes/routes.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  Future<void> _init() async {
    final ConnectivityRepository connectivityRepository = context.read();
    final AuthenticationRepository authenticationRepository = context.read();
    
    final bool hasInternet = await connectivityRepository.hasInternet;

    if (hasInternet) {
      final isSigned = await authenticationRepository.isSignedIn;
      if (isSigned) {
        final user = await authenticationRepository.getUserData();
        if (user != null) {
          _goTo(Routes.home);
        } else if(mounted) {
          _goTo(Routes.signIn);
        }
      } else if(mounted) {
        _goTo(Routes.signIn);
      }
    } else if(mounted) {
      _goTo(Routes.signIn);
    }
  }

  Future<void> _goTo(String routeName) {
    return Navigator.pushReplacementNamed(
      context,
      routeName,
    );
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