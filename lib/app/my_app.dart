import 'package:flutter/material.dart';
import 'package:movies_app/app/generated/assets.gen.dart';
import 'package:movies_app/app/presentation/global/controllers/theme_controller.dart';
import 'package:movies_app/app/presentation/global/theme.dart';
import 'package:movies_app/app/presentation/routes/app_routes.dart';
import 'package:movies_app/app/presentation/routes/routes.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = context.watch();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'Movies App',
        theme: getTheme(themeController.isDarkMode),
        // onGenerateRoute: (settings) {
        //   try {
        //     final uri = Uri.parse(settings.name ?? '');
  
        //     if (uri.path == Routes.movie) {
        //       return null;
        //     }
  
        //     if (uri.path.startsWith(Routes.movie)) {
        //       final int movieId = int.parse(uri.pathSegments.last);
        //       return MaterialPageRoute(
        //         builder: (context) => MovieView(movieId: movieId),
        //         settings: settings,
        //       );
        //     }
  
        //     return null;       
        //   } catch (e) {
        //     return MaterialPageRoute(
        //       builder: (context) => const Scaffold(
        //         body: Center(
        //           child: Text('Error'),
        //         ),
        //       ),
        //       settings: settings,
        //     );
        //   }

        // },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Assets.images.error404.image(),
            ),
          ),
        ),
        initialRoute: Routes.splash,
        routes: appRoutes,
      ),
    );
  }
}