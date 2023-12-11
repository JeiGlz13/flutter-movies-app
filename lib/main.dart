import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movies_app/app/data/repositories_implementation/preferences_repository_impl.dart';
import 'package:movies_app/app/domain/repositories/preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:movies_app/app/presentation/global/controllers/favorites/favorites_controller.dart';
import 'package:movies_app/app/presentation/global/controllers/favorites/state/favorites_state.dart';
import 'package:movies_app/app/presentation/global/controllers/theme_controller.dart';
import 'package:movies_app/app/data/repositories_implementation/account_repository_impl.dart';
import 'package:movies_app/app/data/repositories_implementation/movies_repository_impl.dart';
import 'package:movies_app/app/data/repositories_implementation/popular_repository_impl.dart';
import 'package:movies_app/app/data/services/local/session_service.dart';
import 'package:movies_app/app/data/services/remote/account_service.dart';
import 'package:movies_app/app/data/services/remote/movies_service.dart';
import 'package:movies_app/app/data/services/remote/popular_service.dart';
import 'package:movies_app/app/domain/repositories/account_repository.dart';
import 'package:movies_app/app/domain/repositories/movies_repository.dart';
import 'package:movies_app/app/domain/repositories/popular_repository.dart';
import 'package:movies_app/app/presentation/global/controllers/session_controller.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movies_app/app/data/http/http.dart';
import 'package:movies_app/app/data/repositories_implementation/authentication_repository_impl.dart';
import 'package:movies_app/app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'package:movies_app/app/data/services/remote/authentication_service.dart';
import 'package:movies_app/app/data/services/remote/internet_checker.dart';
import 'package:movies_app/app/domain/repositories/authentication_repository.dart';
import 'package:movies_app/app/domain/repositories/connectivity_repository.dart';
import 'package:movies_app/app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  final SessionService sessionService = SessionService(const FlutterSecureStorage());
  final Http http = Http(
    Client(),
    baseUrl: 'https://api.themoviedb.org/3',
    token: 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1YzgxYjcwZDE0MGU5Njk3ZWRiOGRmZjQxMDgzMzBiMCIsInN1YiI6IjY1MzMxMGJlMzk1NDlhMDEwYjYxMjFiZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.A2RnzvaACHYKavd_8sJE6M0BPJv5PqkzZLk398cJbgs',
  );
  final accountService = AccountService(http, sessionService);

  final isDarkMode = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        Provider<AccountRepository>(
          create: (_) => AccountRepositoryImpl(
            accountService,
            sessionService,
          ),
        ),
        Provider<PreferencesRepository>(
          create: (_) => PreferencesRepositoryImpl(
            sharedPreferences,
          ),
        ),
        Provider<ConnectivityRepository>(
          create: (_) => ConnectivityRepositoryImpl(
            Connectivity(), InternetChecker()
          ),
        ),
        Provider<AuthenticationRepository>(
          create: (_) => AuthenticationRepositoryImpl(
            AuthenticationService(http),
            sessionService,
            accountService,
          ),
        ),
        Provider<PopularRepository>(
          create: (_) => PopularRepositoryImpl(
            PopularService(http),
          ),
        ),
        Provider<MoviesRepository>(
          create: (_) => MoviesRepositoryImpl(
            moviesService: MoviesService(http: http),
          ),
        ),
        ChangeNotifierProvider<ThemeController>(
          create: (context) {
            final PreferencesRepository preferencesRepository = context.read();
            final bool defaultDarkMode = preferencesRepository.isDarkMode ?? isDarkMode;
            return ThemeController(
              defaultDarkMode,
              preferencesRepository: preferencesRepository,
            );
          },
        ),
        ChangeNotifierProvider<SessionController>(
          create: (context) => SessionController(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
        ),
        ChangeNotifierProvider<FavoritesController>(
          create: (context) => FavoritesController(
            FavoritesState.loading(),
            accountService: accountService,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class Injector extends InheritedWidget {
  const Injector({
    super.key, 
    required super.child,
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static Injector of(BuildContext context) {
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, 'Injector could not be found');
    return injector!;
  }
}