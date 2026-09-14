import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/network/api_exception.dart';
import '../../core/widgets/async_value_widget.dart';
import '../../core/widgets/auth_error_banner.dart';
import '../../core/widgets/section_label.dart';
import '../../models/skill.dart';
import '../../models/user_skill.dart';
import '../../providers/auth_provider.dart';
import '../../providers/core_providers.dart';
import '../../providers/exchanges_provider.dart';
import '../../providers/matches_provider.dart';
import '../../providers/profile_provider.dart';

class SendRequestScreen extends ConsumerStatefulWidget {
  const SendRequestScreen({super.key, required this.userId});

  final int userId;

  @override
  ConsumerState<SendRequestScreen> createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends ConsumerState<SendRequestScreen> {
  int? _offeredSkillId;
  int? _wantedSkillId;
  final _messageController = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final myId = ref.read(authProvider).userId;
    if (myId == widget.userId) {
      setState(() => _error = "You can't send a swap request to yourself.");
      return;
    }
    if (_offeredSkillId == null || _wantedSkillId == null) {
      setState(
        () => _error = 'Pick a skill to offer and a skill you want to learn.',
      );
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(exchangesRepositoryProvider)
          .createExchange(
            receiverId: widget.userId,
            offeredSkillId: _offeredSkillId!,
            wantedSkillId: _wantedSkillId!,
            message: _messageController.text.trim(),
          );
      invalidateExchanges(ref);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Swap request sent!')));
        context.pop();
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
    final mySkillsAsync = ref.watch(mySkillsProvider);
    final matchAsync = ref.watch(matchDetailProvider(widget.userId));

    return Scaffold(
      appBar: AppBar(title: const Text('Send swap request')),
      body: AsyncValueWidget(
        value: mySkillsAsync,
        onRetry: () => ref.invalidate(mySkillsProvider),
        data: (mySkills) => AsyncValueWidget(
          value: matchAsync,
          onRetry: () => ref.invalidate(matchDetailProvider(widget.userId)),
          data: (match) => _buildForm(
            context,
            mySkills: mySkills,
            theirSkills: match.skillsTheyCanTeachYou.isNotEmpty
                ? match.skillsTheyCanTeachYou
                : match.skillsYouCanTeachThem,
          ),
        ),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context, {
    required List<UserSkill> mySkills,
    required List<Skill> theirSkills,
  }) {
    final teachSkills = mySkills.where((s) => s.type.name == 'teach').toList();
    final offeredOptions = teachSkills.isNotEmpty ? teachSkills : mySkills;
    final mutedStyle = TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (_error != null) ...[
          AuthErrorBanner(_error!),
          const SizedBox(height: 16),
        ],
        const SectionLabel('A skill you can offer'),
        const SizedBox(height: 8),
        if (offeredOptions.isEmpty)
          Text('Add a skill to your profile first.', style: mutedStyle)
        else
          DropdownButtonFormField<int>(
            initialValue: _offeredSkillId,
            decoration: const InputDecoration(),
            hint: const Text('Choose a skill you teach'),
            items: offeredOptions
                .map(
                  (us) => DropdownMenuItem(
                    value: us.skill.id,
                    child: Text(us.skill.name),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => _offeredSkillId = value),
          ),
        const SizedBox(height: 20),
        const SectionLabel('A skill you want to learn from them'),
        const SizedBox(height: 8),
        if (theirSkills.isEmpty)
          Text('No listed skills to choose from.', style: mutedStyle)
        else
          DropdownButtonFormField<int>(
            initialValue: _wantedSkillId,
            decoration: const InputDecoration(),
            hint: const Text('Choose one of their skills'),
            items: theirSkills
                .map((s) => DropdownMenuItem(value: s.id, child: Text(s.name)))
                .toList(),
            onChanged: (value) => setState(() => _wantedSkillId = value),
          ),
        const SizedBox(height: 20),
        const SectionLabel('Message (optional)'),
        const SizedBox(height: 8),
        TextField(
          controller: _messageController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: "Introduce yourself or suggest a time...",
          ),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: _submitting ? null : _submit,
          child: _submitting
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : const Text('Send request'),
        ),
      ],
    );
  }
}
