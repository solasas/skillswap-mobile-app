import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/network/api_exception.dart';
import '../../core/widgets/auth_error_banner.dart';
import '../../providers/core_providers.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // Client-side validation
    if (_currentPasswordController.text.trim().isEmpty) {
      setState(() => _error = 'Current password is required.');
      return;
    }
    if (_newPasswordController.text.trim().isEmpty) {
      setState(() => _error = 'New password is required.');
      return;
    }
    if (_confirmPasswordController.text.trim().isEmpty) {
      setState(() => _error = 'Confirm password is required.');
      return;
    }
    if (_newPasswordController.text.length < 6) {
      setState(() => _error = 'New password must be at least 6 characters.');
      return;
    }
    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() => _error = 'New passwords do not match.');
      return;
    }
    if (_newPasswordController.text.trim() == _currentPasswordController.text.trim()) {
      setState(() => _error = 'New password must be different from the current password.');
      return;
    }

    setState(() {
      _submitting = true;
      _error = null;
    });

    try {
      await ref.read(profileRepositoryProvider).changePassword(
        currentPassword: _currentPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
      );
      if (mounted) {
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password changed.')),
        );
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
    return Scaffold(
      appBar: AppBar(title: const Text('Change password')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_error != null) ...[
            AuthErrorBanner(_error!),
            const SizedBox(height: 16),
          ],
          TextField(
            controller: _currentPasswordController,
            decoration: const InputDecoration(labelText: 'Current password'),
            obscureText: true,
            enabled: !_submitting,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _newPasswordController,
            decoration: const InputDecoration(labelText: 'New password'),
            obscureText: true,
            enabled: !_submitting,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(labelText: 'Confirm new password'),
            obscureText: true,
            enabled: !_submitting,
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
                : const Text('Change password'),
          ),
        ],
      ),
    );
  }
}
