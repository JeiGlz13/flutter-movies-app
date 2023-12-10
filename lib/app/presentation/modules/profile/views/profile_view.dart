import 'package:flutter/material.dart';
import 'package:movies_app/app/presentation/global/controllers/theme_controller.dart';
import 'package:movies_app/app/presentation/global/extensions/build_context_ext.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Dark mode'),
                value: context.isDarkMode,
                onChanged: (value) {
                  context.read<ThemeController>().onChange(value);
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}