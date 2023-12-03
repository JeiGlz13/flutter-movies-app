import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/repositories/account_repository.dart';
import 'package:movies_app/app/domain/repositories/authentication_repository.dart';
import 'package:movies_app/app/domain/repositories/connectivity_repository.dart';
import 'package:movies_app/app/presentation/global/controllers/favorites/favorites_controller.dart';
import 'package:movies_app/app/presentation/global/controllers/session_controller.dart';
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
    final AccountRepository accountRepository = context.read();
    final SessionController sessionController = context.read();
    final FavoritesController favoritesController = context.read();
    
    final bool hasInternet = await connectivityRepository.hasInternet;

    if (hasInternet) {
      final isSigned = await authenticationRepository.isSignedIn;
      if (isSigned) {
        final user = await accountRepository.getUserData();
        if (user != null) {
          sessionController.setUser(user);
          favoritesController.init();
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