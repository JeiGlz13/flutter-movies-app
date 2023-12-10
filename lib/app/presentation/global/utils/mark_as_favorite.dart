import 'package:flutter/material.dart';
import 'package:movies_app/app/domain/enums/trend_type.dart';
import 'package:movies_app/app/domain/models/trend_media/trend_media.dart';
import 'package:movies_app/app/presentation/global/controllers/favorites/favorites_controller.dart';
import 'package:movies_app/app/presentation/global/dialogs/show_loader.dart';
import 'package:provider/provider.dart';

Future<void> markAsFavorite(
  {
    required BuildContext context,
    required TrendMedia media,
    required TrendType type,
    required bool Function() mounted,
  }
) async {
  final FavoritesController favoritesController = context.read();
  final result = await showLoader(
    context,
    favoritesController.markAsFavorite(media, type),
  );

  if (!mounted()) return;

  result.whenOrNull(
    error: (value) {
      final String errorMessage = value.when(
        notFound: () => 'Resource not found',
        network: () => 'Network error',
        unauthorized: () => 'Unauthorized',
        unknown: () => 'Unknown error',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage))
      );
    },
  );
}