import 'package:flutter/material.dart';
import 'package:movies_app/app/presentation/routes/app_routes.dart';
import 'package:movies_app/app/presentation/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'Movies App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: Routes.splash,
        routes: appRoutes,
      ),
    );
  }
}