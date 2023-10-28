import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movies_app/app/data/repositories_implementation/authentication_repository_impl.dart';
import 'package:movies_app/app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'package:movies_app/app/data/services/remote/authentication_service.dart';
import 'package:movies_app/app/data/services/remote/internet_checker.dart';
import 'package:movies_app/app/domain/repositories/authentication_repository.dart';
import 'package:movies_app/app/domain/repositories/connectivity_repository.dart';
import 'package:movies_app/app/my_app.dart';

void main() {
  runApp(
    Injector(
      authenticationRepository: AuthenticationRepositoryImpl(
        const FlutterSecureStorage(),
        AuthenticationService(client: http.Client()),
      ),
      connectivityRepository: ConnectivityRepositoryImpl(
        Connectivity(),
        InternetChecker(),
      ),
      child: const MyApp(),
    ),
  );
}

class Injector extends InheritedWidget {
  const Injector({
    super.key, 
    required super.child,
    required this.authenticationRepository,
    required this.connectivityRepository,
  });

  final ConnectivityRepository connectivityRepository;
  final AuthenticationRepository authenticationRepository;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static Injector of(BuildContext context) {
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, 'Injector could not be found');
    return injector!;
  }
}