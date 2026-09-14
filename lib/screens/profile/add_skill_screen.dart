import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/network/api_exception.dart';
import '../../core/utils/enums.dart';
import '../../core/widgets/async_value_widget.dart';
import '../../core/widgets/auth_error_banner.dart';
import '../../core/widgets/section_label.dart';
import '../../models/skill.dart';
import '../../providers/core_providers.dart';
import '../../providers/profile_provider.dart';
import '../../providers/skills_provider.dart';

class AddSkillScreen extends ConsumerStatefulWidget {
  const AddSkillScreen({super.key});

  @override
  ConsumerState<AddSkillScreen> createState() => _AddSkillScreenState();
}

class _AddSkillScreenState extends ConsumerState<AddSkillScreen> {
  SkillCategory? _filterCategory;
  int? _selectedSkillId;
  SkillType _type = SkillType.teach;
  SkillLevel _level = SkillLevel.beginner;
  bool _creatingNew = false;

  final _newSkillNameController = TextEditingController();
  final _newSkillDescController = TextEditingController();
  SkillCategory _newSkillCategory = SkillCategory.other;

  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _newSkillNameController.dispose();
    _newSkillDescController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      int skillId;
      if (_creatingNew) {
        if (_newSkillNameController.text.trim().isEmpty) {
          setState(() {
            _error = 'Enter a name for the new skill.';
            _submitting = false;
          });
          return;
        }
        final created = await ref
            .read(skillsRepositoryProvider)
            .createSkill(
              name: _newSkillNameController.text.trim(),
              category: _newSkillCategory,
              description: _newSkillDescController.text.trim(),
            );
        skillId = created.id;
      } else {
        if (_selectedSkillId == null) {
          setState(() {
            _error = 'Choose a skill.';
            _submitting = false;
          });
          return;
        }
        skillId = _selectedSkillId!;
      }

      await ref
          .read(profileRepositoryProvider)
          .addSkill(skillId: skillId, type: _type, level: _level);
      ref.invalidate(mySkillsProvider);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Skill added!')));
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
    final skillsAsync = ref.watch(skillsByCategoryProvider(_filterCategory));

    return Scaffold(
      appBar: AppBar(title: const Text('Add a skill')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_error != null) ...[
            AuthErrorBanner(_error!),
            const SizedBox(height: 16),
          ],
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Create a new skill'),
            subtitle: const Text("Turn on if it's not in the list below"),
            value: _creatingNew,
            onChanged: (value) => setState(() => _creatingNew = value),
          ),
          const SizedBox(height: 8),
          if (_creatingNew) ...[
            TextField(
              controller: _newSkillNameController,
              decoration: const InputDecoration(labelText: 'Skill name'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<SkillCategory>(
              initialValue: _newSkillCategory,
              decoration: const InputDecoration(labelText: 'Category'),
              items: SkillCategory.values
                  .map((c) => DropdownMenuItem(value: c, child: Text(c.label)))
                  .toList(),
              onChanged: (value) => setState(
                () => _newSkillCategory = value ?? SkillCategory.other,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _newSkillDescController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
              ),
            ),
          ] else ...[
            DropdownButtonFormField<SkillCategory?>(
              initialValue: _filterCategory,
              decoration: const InputDecoration(
                labelText: 'Filter by category',
              ),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('All categories'),
                ),
                ...SkillCategory.values.map(
                  (c) => DropdownMenuItem(value: c, child: Text(c.label)),
                ),
              ],
              onChanged: (value) => setState(() {
                _filterCategory = value;
                _selectedSkillId = null;
              }),
            ),
            const SizedBox(height: 16),
            AsyncValueWidget<List<Skill>>(
              value: skillsAsync,
              onRetry: () =>
                  ref.invalidate(skillsByCategoryProvider(_filterCategory)),
              data: (skills) => DropdownButtonFormField<int>(
                initialValue: _selectedSkillId,
                decoration: const InputDecoration(labelText: 'Skill'),
                items: skills
                    .map(
                      (s) => DropdownMenuItem(value: s.id, child: Text(s.name)),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _selectedSkillId = value),
              ),
            ),
          ],
          const SizedBox(height: 20),
          const SectionLabel('I want to...'),
          const SizedBox(height: 8),
          SegmentedButton<SkillType>(
            segments: const [
              ButtonSegment(
                value: SkillType.teach,
                label: Text('Teach it'),
                icon: Icon(Icons.school_outlined),
              ),
              ButtonSegment(
                value: SkillType.learn,
                label: Text('Learn it'),
                icon: Icon(Icons.menu_book_outlined),
              ),
            ],
            selected: {_type},
            onSelectionChanged: (selection) =>
                setState(() => _type = selection.first),
          ),
          const SizedBox(height: 20),
          const SectionLabel('My level'),
          const SizedBox(height: 8),
          SegmentedButton<SkillLevel>(
            segments: SkillLevel.values
                .map((l) => ButtonSegment(value: l, label: Text(l.label)))
                .toList(),
            selected: {_level},
            onSelectionChanged: (selection) =>
                setState(() => _level = selection.first),
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
                : const Text('Add skill'),
          ),
        ],
      ),
    );
  }
}
