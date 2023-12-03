import 'package:flutter/material.dart';
import 'package:movies_app/app/presentation/global/controllers/favorites/favorites_controller.dart';
import 'package:movies_app/app/presentation/global/controllers/session_controller.dart';
import 'package:movies_app/app/presentation/modules/sign_in/controller/sign_in_controller.dart';
import 'package:movies_app/app/presentation/routes/routes.dart';
import 'package:provider/provider.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController signInController = Provider.of(context, listen: true);
    if(signInController.state.isLoading) {
      return const CircularProgressIndicator();
    }
    return MaterialButton(
      color: Colors.blue.shade700,
      textColor: Colors.white,
      onPressed: () {
        final isValid = Form.of(context).validate();
        if (isValid) {
          _submit(context);
        }
      },
      child: const Text('Sign In'),
    );
  }
}

Future<void> _submit(BuildContext context) async {
  final SignInController signInController = context.read();
  if (!signInController.isMounted) {
    return;
  }

  final result = await signInController.submit();

  result.when(
    error: (failure) {
      final String message = failure.when(
        notFound: () => 'Not found',
        network: () => 'Network error',
        unauthorized: () => 'Unauthorized',
        unknown: () => 'Unknown',
        notVerified: () => 'Email not verified',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
      );
      return message;
    },
    success: (user) {
      final SessionController sessionController = context.read();
      final FavoritesController favoritesController = context.read();

      sessionController.setUser(user);
      favoritesController.init();
      Navigator.pushReplacementNamed(context, Routes.home);
    },
  );
}