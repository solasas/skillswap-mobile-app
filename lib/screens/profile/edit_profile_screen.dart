import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/network/api_exception.dart';
import '../../core/widgets/async_value_widget.dart';
import '../../core/widgets/auth_error_banner.dart';
import '../../models/user.dart';
import '../../providers/core_providers.dart';
import '../../providers/profile_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _cityController = TextEditingController();
  bool _initialized = false;
  bool _submitting = false;
  String? _error;

  void _initFrom(User user) {
    if (_initialized) return;
    _nameController.text = user.name;
    _bioController.text = user.bio ?? '';
    _cityController.text = user.city ?? '';
    _initialized = true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(profileRepositoryProvider)
          .updateMe(
            name: _nameController.text.trim(),
            bio: _bioController.text.trim(),
            city: _cityController.text.trim(),
          );
      ref.invalidate(myProfileProvider);
      if (mounted) context.pop();
    } on ApiException catch (e) {
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(myProfileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit profile')),
      body: AsyncValueWidget<User>(
        value: profileAsync,
        onRetry: () => ref.invalidate(myProfileProvider),
        data: (user) {
          _initFrom(user);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (_error != null) ...[
                AuthErrorBanner(_error!),
                const SizedBox(height: 16),
              ],
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _bioController,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Bio'),
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
                    : const Text('Save'),
              ),
            ],
          );
        },
      ),
    );
  }
}
