import 'package:flutter/material.dart';
import 'package:movies_app/app/presentation/modules/favorites/views/favorites_view.dart';
import 'package:movies_app/app/presentation/modules/home/views/home_view.dart';
import 'package:movies_app/app/presentation/modules/profile/views/profile_view.dart';
import 'package:movies_app/app/presentation/modules/sign_in/views/sign_in_view.dart';
import 'package:movies_app/app/presentation/modules/splash/views/splash_view.dart';
import 'package:movies_app/app/presentation/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashView(),
    Routes.signIn: (context) => const SignInView(),
    Routes.home: (context) => const HomeView(),
    Routes.favorite: (context) => const FavoritesView(),
    Routes.profile: (context) => const ProfileView(),
  };
}