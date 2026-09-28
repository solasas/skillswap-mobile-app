import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/messages_provider.dart';

class HomeShell extends ConsumerWidget {
  const HomeShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCountAsync = ref.watch(unreadCountProvider);
    final unreadCount = unreadCountAsync.maybeWhen(
      data: (count) => count > 0 ? count : 0,
      orElse: () => 0,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Text(
                navigationShell.currentIndex == 0
                    ? 'Matches'
                    : navigationShell.currentIndex == 1
                        ? 'Requests'
                        : navigationShell.currentIndex == 2
                            ? 'Sessions'
                            : navigationShell.currentIndex == 3
                                ? 'Messages'
                                : 'Profile',
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () => context.push('/search'),
            ),
            IconButton(
              icon: const Icon(Icons.person_outline),
              tooltip: 'Profile',
              onPressed: () {
                navigationShell.goBranch(
                  4,
                  initialLocation: navigationShell.currentIndex == 4,
                );
              },
            ),
          ],
        ),
      ),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Matches',
          ),
          const NavigationDestination(
            icon: Icon(Icons.swap_horiz_outlined),
            selectedIcon: Icon(Icons.swap_horiz),
            label: 'Requests',
          ),
          const NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Sessions',
          ),
          NavigationDestination(
            icon: unreadCount > 0
                ? Badge(label: Text(unreadCount.toString()), child: const Icon(Icons.chat_bubble_outline))
                : const Icon(Icons.chat_bubble_outline),
            selectedIcon: unreadCount > 0
                ? Badge(label: Text(unreadCount.toString()), child: const Icon(Icons.chat_bubble))
                : const Icon(Icons.chat_bubble),
            label: 'Messages',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
