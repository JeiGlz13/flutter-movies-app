import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/app/data/repositories_implementation/account_repository_impl.dart';
import 'package:movies_app/app/domain/repositories/account_repository.dart';
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

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AccountRepository>(
          create: (_) => AccountRepositoryImpl(),
        ),
        Provider<ConnectivityRepository>(
          create: (_) => ConnectivityRepositoryImpl(
            Connectivity(), InternetChecker()
          ),
        ),
        Provider<AuthenticationRepository>(
          create: (_) => AuthenticationRepositoryImpl(
            const FlutterSecureStorage(),
            AuthenticationService(
              Http(
                http.Client(),
                baseUrl: 'https://api.themoviedb.org/3',
                token: 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1YzgxYjcwZDE0MGU5Njk3ZWRiOGRmZjQxMDgzMzBiMCIsInN1YiI6IjY1MzMxMGJlMzk1NDlhMDEwYjYxMjFiZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.A2RnzvaACHYKavd_8sJE6M0BPJv5PqkzZLk398cJbgs',
              ),
            ),
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