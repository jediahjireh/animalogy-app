import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/browse')) return 1;
    if (location.startsWith('/library')) return 2;
    if (location.startsWith('/mascots')) return 3;
    return 0;
  }

  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
      case 1:
        context.go('/browse');
      case 2:
        context.go('/library');
      case 3:
        context.go('/mascots');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex(context),
        onDestinationSelected: (i) => _onTap(i, context),
        backgroundColor: AnimalColors.surface,
        indicatorColor: AnimalColors.primaryLight,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_stories_outlined),
            selectedIcon: Icon(Icons.auto_stories),
            label: 'Browse',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.bookmark),
            label: 'Library',
          ),
          NavigationDestination(
            icon: Icon(Icons.pets_outlined),
            selectedIcon: Icon(Icons.pets),
            label: 'Mascots',
          ),
        ],
      ),
    );
  }
}
