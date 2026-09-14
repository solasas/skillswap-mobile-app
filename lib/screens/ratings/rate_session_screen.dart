import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/network/api_exception.dart';
import '../../core/utils/enums.dart';
import '../../core/widgets/async_value_widget.dart';
import '../../core/widgets/star_rating.dart';
import '../../models/session.dart';
import '../../providers/auth_provider.dart';
import '../../providers/core_providers.dart';
import '../../providers/sessions_provider.dart';

class RateSessionScreen extends ConsumerStatefulWidget {
  const RateSessionScreen({super.key, required this.sessionId});

  final int sessionId;

  @override
  ConsumerState<RateSessionScreen> createState() => _RateSessionScreenState();
}

class _RateSessionScreenState extends ConsumerState<RateSessionScreen> {
  int _stars = 5;
  final _reviewController = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref.read(ratingsRepositoryProvider).rateSession(
            sessionId: widget.sessionId,
            stars: _stars,
            review: _reviewController.text.trim(),
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rating submitted!')));
        context.pop();
      }
    } on ApiException catch (e) {
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(sessionDetailProvider(widget.sessionId));
    final myId = ref.watch(authProvider).userId;

    return Scaffold(
      appBar: AppBar(title: const Text('Rate session')),
      body: AsyncValueWidget<Session>(
        value: sessionAsync,
        onRetry: () => ref.invalidate(sessionDetailProvider(widget.sessionId)),
        data: (session) {
          if (session.status != SessionStatus.completed) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Text('You can only rate a session once it has been completed.'),
            );
          }
          final exchange = session.exchange;
          final other = exchange.requester.id == myId ? exchange.receiver : exchange.requester;

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text('Rate ${other.name}', style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              if (_error != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(_error!, style: const TextStyle(color: Colors.red)),
                ),
                const SizedBox(height: 16),
              ],
              Center(child: StarRatingInput(value: _stars, onChanged: (v) => setState(() => _stars = v))),
              const SizedBox(height: 24),
              TextField(
                controller: _reviewController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Review (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _submitting ? null : _submit,
                child: _submitting
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text('Submit rating'),
              ),
            ],
          );
        },
      ),
    );
  }
}
