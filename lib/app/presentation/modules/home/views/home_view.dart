import 'package:flutter/material.dart';
import 'package:movies_app/app/presentation/routes/routes.dart';
import 'package:movies_app/main.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            Injector.of(context).authenticationRepository.signOut();
            Navigator.pushReplacementNamed(context, Routes.signIn);
          },
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}