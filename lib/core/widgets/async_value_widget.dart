import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/api_exception.dart';

/// Renders a Riverpod AsyncValue with consistent loading/error/data states
/// and a pull-to-refresh-friendly retry action.
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.onRetry,
    this.loadingBuilder,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;
  final WidgetBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () =>
          loadingBuilder?.call(context) ??
          const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _ErrorView(error: error, onRetry: onRetry),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error, this.onRetry});

  final Object error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final err = error;
    final message = err is ApiException ? err.message : 'Something went wrong.';
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(color: scheme.errorContainer, shape: BoxShape.circle),
              child: Icon(Icons.priority_high_rounded, size: 30, color: scheme.error),
            ),
            const SizedBox(height: 14),
            Text(message, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              OutlinedButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ],
        ),
      ),
    );
  }
}
