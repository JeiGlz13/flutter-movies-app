import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/enums/sign_in_fail.dart';
import 'package:movies_app/app/presentation/routes/routes.dart';
import 'package:movies_app/main.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _username = '', _password = '';
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            child: AbsorbPointer(
              absorbing: _isLoading,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      setState(() {
                        _username = value.trim().toLowerCase();
                      });
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
                      setState(() {
                        _password = value.trim();
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Password'
                    ),
                    validator: (text) {
                      text = text?.replaceAll(' ', '').toLowerCase() ?? '';
                      return (text.isEmpty) ? 'Invalid username' : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Builder(
                    builder: (context) {
                      if (_isLoading) {
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _submit(BuildContext context) async {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final result = await Injector.of(context).authenticationRepository
      .signIn(_username, _password);

    result.when((failure) {
      final message = {
        SignInFail.notFound: 'Not Found',
        SignInFail.unauthorized: 'Unauthorized',
        SignInFail.unknown: 'Unknown',
        SignInFail.network: 'Network error',
      }[failure];

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message ?? ''))
      );
      return message;
    }, (user) {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }
}