import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/enums/sign_in_fail.dart';
import 'package:movies_app/app/domain/repositories/authentication_repository.dart';
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

  result.when((failure) {
    final message = {
      SignInFail.notFound: 'Not Found',
      SignInFail.unauthorized: 'Unauthorized',
      SignInFail.unknown: 'Unknown',
      SignInFail.network: 'Network error',
    }[failure];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message ?? ''))
    );
    return message;
  }, (user) {
    final SessionController sessionController = context.read();
    sessionController.setUser(user);
    Navigator.pushReplacementNamed(context, Routes.home);
  });
}