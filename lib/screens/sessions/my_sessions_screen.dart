import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/utils/enums.dart';
import '../../core/widgets/async_value_widget.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/status_badge.dart';
import '../../models/session.dart';
import '../../providers/sessions_provider.dart';

class MySessionsScreen extends ConsumerWidget {
  const MySessionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(mySessionsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('My sessions')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(mySessionsProvider),
        child: AsyncValueWidget<List<Session>>(
          value: sessionsAsync,
          onRetry: () => ref.invalidate(mySessionsProvider),
          data: (sessions) {
            if (sessions.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 120),
                  EmptyState(
                    icon: Icons.calendar_today_outlined,
                    message:
                        'No sessions yet.\nSchedule one from an accepted swap request.',
                  ),
                ],
              );
            }
            final sorted = [...sessions]
              ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: sorted.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final session = sorted[index];
                return Card(
                  child: ListTile(
                    onTap: () => context.push('/sessions/${session.id}'),
                    leading: Icon(
                      session.mode == SessionMode.online
                          ? Icons.videocam_outlined
                          : Icons.place_outlined,
                    ),
                    title: Text(
                      DateFormat.yMMMd().add_jm().format(session.dateTime),
                    ),
                    subtitle: Text(
                      '${session.exchange.offeredSkill.name} ↔ ${session.exchange.wantedSkill.name}\n${session.durationMinutes} min · ${session.mode.label}',
                    ),
                    isThreeLine: true,
                    trailing: StatusBadge.session(session.status),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
