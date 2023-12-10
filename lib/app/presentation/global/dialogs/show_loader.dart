import 'package:flutter/material.dart';

Future<T> showLoader<T>(
  BuildContext context,
  Future<T> future,
) async {
  final overlayState = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Container(
      color: Colors.black45,
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    ),
  );
  overlayState.insert(overlayEntry);

  final result = await future;
  overlayEntry.remove();
  return result;
}