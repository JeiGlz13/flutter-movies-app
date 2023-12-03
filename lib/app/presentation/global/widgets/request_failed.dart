import 'package:flutter/material.dart';
import 'package:movies_app/app/generated/assets.gen.dart';

class RequestFailed extends StatelessWidget {
  final VoidCallback onRetry;
  final String text;
  const RequestFailed({
    super.key,
    required this.onRetry,
    this.text = 'Request failed',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Assets.images.error404.image()),
          MaterialButton(
            onPressed: onRetry,
            color: Colors.blue.shade700,
            textColor: Colors.white,
            child: const Text('Retry'),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}