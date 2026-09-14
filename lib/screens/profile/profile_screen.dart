import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/network/api_exception.dart';
import '../../core/utils/enums.dart';
import '../../core/widgets/async_value_widget.dart';
import '../../core/widgets/empty_state.dart';
import '../../models/user.dart';
import '../../models/user_skill.dart';
import '../../providers/auth_provider.dart';
import '../../providers/core_providers.dart';
import '../../providers/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(myProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
            onPressed: () => _confirmLogout(context, ref),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(myProfileProvider);
          ref.invalidate(mySkillsProvider);
        },
        child: AsyncValueWidget<User>(
          value: profileAsync,
          onRetry: () => ref.invalidate(myProfileProvider),
          data: (user) => _ProfileBody(user: user),
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('You will need to sign in again to continue.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Log out')),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(authProvider.notifier).logout();
    }
  }
}

class _ProfileBody extends ConsumerWidget {
  const _ProfileBody({required this.user});

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillsAsync = ref.watch(mySkillsProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            CircleAvatar(radius: 32, child: Text(user.name.isNotEmpty ? user.name[0].toUpperCase() : '?')),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: Theme.of(context).textTheme.titleLarge),
                  Text(user.email, style: Theme.of(context).textTheme.bodySmall),
                  if (user.city != null) Text(user.city!),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => context.push('/profile/edit'),
            ),
          ],
        ),
        if (user.bio != null && user.bio!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(user.bio!),
        ],
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            icon: const Icon(Icons.star_outline),
            label: const Text('My reputation'),
            onPressed: () => context.push('/users/${user.id}/ratings'),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('My skills', style: Theme.of(context).textTheme.titleMedium),
            TextButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add'),
              onPressed: () => context.push('/profile/skills/add'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AsyncValueWidget<List<UserSkill>>(
          value: skillsAsync,
          onRetry: () => ref.invalidate(mySkillsProvider),
          data: (skills) {
            if (skills.isEmpty) {
              return const EmptyState(icon: Icons.school_outlined, message: 'No skills added yet.');
            }
            return Column(
              children: skills.map((us) => _SkillTile(userSkill: us)).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _SkillTile extends ConsumerWidget {
  const _SkillTile({required this.userSkill});

  final UserSkill userSkill;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: Icon(userSkill.type.name == 'teach' ? Icons.school_outlined : Icons.menu_book_outlined),
        title: Text(userSkill.skill.name),
        subtitle: Text('${userSkill.type.label} · ${userSkill.level.label} · ${userSkill.skill.category.label}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () async {
            try {
              await ref.read(profileRepositoryProvider).deleteSkill(userSkill.id);
              ref.invalidate(mySkillsProvider);
            } on ApiException catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
              }
            }
          },
        ),
      ),
    );
  }
}
