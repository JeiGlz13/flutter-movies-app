import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/repositories/authentication_repository.dart';
import 'package:movies_app/app/presentation/global/controllers/session_controller.dart';
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
    final SessionController sessionController = context.read();
    final user = sessionController.state;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(user?.avatarPath != null)
              Image.network('https://image.tmdb.org/t/p/w500${user?.avatarPath}'),
            Text(user?.username ?? ''),
            Text(user?.id.toString() ?? ''),
            Text(user?.name ?? ''),
            TextButton(
              onPressed: () async {
                await sessionController.signOut();
                if (mounted) {
                  Navigator.pushReplacementNamed(context, Routes.signIn);
                }
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}