import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/enums.dart';
import '../../core/widgets/async_value_widget.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/star_rating.dart';
import '../../models/user.dart';
import '../../providers/search_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  Future<void>? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.ignore();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.ignore();
    _debounce = Future.delayed(const Duration(milliseconds: 400), () {
      ref.read(userSearchFiltersProvider.notifier).state = ref
          .read(userSearchFiltersProvider)
          .copyWith(skillName: query.isEmpty ? null : query);
    });
  }

  Future<void> _showFilterSheet() async {
    final filters = ref.read(userSearchFiltersProvider);
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _FilterSheet(initialFilters: filters),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: _showFilterSheet,
            tooltip: 'Filters',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by skill...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final resultsAsync = ref.watch(userSearchResultsProvider);
                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(userSearchResultsProvider),
                  child: AsyncValueWidget<List<User>>(
                    value: resultsAsync,
                    onRetry: () => ref.invalidate(userSearchResultsProvider),
                    data: (users) {
                      if (users.isEmpty) {
                        return ListView(
                          children: const [
                            SizedBox(height: 120),
                            EmptyState(
                              icon: Icons.search_off,
                              message: 'No one matches these filters yet.',
                            ),
                          ],
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: users.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return _UserCard(user: user);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.1),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/matches/${user.id}'),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: theme.colorScheme.primaryContainer,
                foregroundColor: theme.colorScheme.onPrimaryContainer,
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (user.city != null && user.city!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        user.city!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    const SizedBox(height: 6),
                    if (user.totalRatings != null && user.totalRatings! > 0)
                      Row(
                        children: [
                          StarRatingDisplay(
                            stars: user.averageRating ?? 0.0,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${(user.averageRating ?? 0.0).toStringAsFixed(1)} (${user.totalRatings})',
                            style: theme.textTheme.labelSmall,
                          ),
                        ],
                      )
                    else
                      Text(
                        'No ratings yet',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterSheet extends ConsumerStatefulWidget {
  const _FilterSheet({required this.initialFilters});

  final UserSearchFilters initialFilters;

  @override
  ConsumerState<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends ConsumerState<_FilterSheet> {
  late TextEditingController _cityController;
  late TextEditingController _minRatingController;
  SkillLevel? _selectedLevel;
  bool _availableOnly = false;

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController(text: widget.initialFilters.city ?? '');
    _minRatingController =
        TextEditingController(text: widget.initialFilters.minRating?.toString() ?? '');
    _selectedLevel = widget.initialFilters.level;
    _availableOnly = widget.initialFilters.availableOnly ?? false;
  }

  @override
  void dispose() {
    _cityController.dispose();
    _minRatingController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    final minRating =
        _minRatingController.text.isEmpty ? null : double.tryParse(_minRatingController.text);
    ref.read(userSearchFiltersProvider.notifier).state = UserSearchFilters(
      skillName: widget.initialFilters.skillName,
      city: _cityController.text.isEmpty ? null : _cityController.text,
      level: _selectedLevel,
      minRating: minRating,
      availableOnly: _availableOnly ? true : null,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filters',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'City',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: 'e.g., San Francisco',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Skill Level',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            SegmentedButton<SkillLevel?>(
              segments: const [
                ButtonSegment(label: Text('Any'), value: null),
                ButtonSegment(label: Text('Beginner'), value: SkillLevel.beginner),
                ButtonSegment(label: Text('Intermediate'), value: SkillLevel.intermediate),
                ButtonSegment(label: Text('Advanced'), value: SkillLevel.advanced),
              ],
              selected: {_selectedLevel},
              onSelectionChanged: (Set<SkillLevel?> newSelection) {
                setState(() => _selectedLevel = newSelection.first);
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Minimum Rating',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _minRatingController,
              decoration: InputDecoration(
                hintText: '0.0 - 5.0',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Available only'),
              subtitle: const Text('Only users with availability slots'),
              value: _availableOnly,
              onChanged: (value) => setState(() => _availableOnly = value),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _applyFilters,
                child: const Text('Apply Filters'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
