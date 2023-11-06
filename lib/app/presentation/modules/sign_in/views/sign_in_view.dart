import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/repositories/authentication_repository.dart';
import 'package:movies_app/app/presentation/modules/sign_in/controller/sign_in_controller.dart';
import 'package:movies_app/app/presentation/modules/sign_in/controller/sign_in_state.dart';
import 'package:movies_app/app/presentation/modules/sign_in/views/widgets/submit_button.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInController(
        const SignInState(),
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Builder(
                builder: (context) {
                  final signInController = Provider.of<SignInController>(context, listen: true);
                  return AbsorbPointer(
                    absorbing: signInController.state.isLoading,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            signInController.onUsernameChanged(value);
                          },
                          decoration: const InputDecoration(
                            hintText: 'Username'
                          ),
                          validator: (text) {
                            text = text?.trim().toLowerCase() ?? '';
                            return (text.isEmpty) ? 'Invalid username' : null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            signInController.onPasswordChanged(value);
                          },
                          decoration: const InputDecoration(
                            hintText: 'Password'
                          ),
                          validator: (text) {
                            text = text?.replaceAll(' ', '') ?? '';
                            return (text.isEmpty) ? 'Invalid username' : null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const SubmitButton(),
                      ],
                    ),
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}