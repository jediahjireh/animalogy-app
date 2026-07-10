import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';

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
    final selected = _selectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AnimalColors.surface,
          border: Border(
            top: BorderSide(
              color: AnimalColors.borderBold,
              width: Dimensions.borderMd,
            ),
          ),
          boxShadow: const [
            BoxShadow(
              color: AnimalColors.cardShadow,
              offset: Offset(0, -2),
              blurRadius: 8,
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.sm,
              vertical: Dimensions.sm,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: 'Home',
                  isSelected: selected == 0,
                  onTap: () => _onTap(0, context),
                ),
                _NavItem(
                  icon: Icons.auto_stories_outlined,
                  activeIcon: Icons.auto_stories,
                  label: 'Browse',
                  isSelected: selected == 1,
                  onTap: () => _onTap(1, context),
                ),
                _NavItem(
                  icon: Icons.bookmark_border,
                  activeIcon: Icons.bookmark,
                  label: 'Library',
                  isSelected: selected == 2,
                  onTap: () => _onTap(2, context),
                ),
                _NavItem(
                  icon: Icons.pets_outlined,
                  activeIcon: Icons.pets,
                  label: 'Mascots',
                  isSelected: selected == 3,
                  onTap: () => _onTap(3, context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.md,
                vertical: Dimensions.xs,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AnimalColors.primary.withValues(alpha: 0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(Dimensions.radiusRound),
                border: isSelected
                    ? Border.all(
                        color: AnimalColors.primary.withValues(alpha: 0.3),
                        width: Dimensions.borderThin,
                      )
                    : null,
              ),
              child: Icon(
                isSelected ? activeIcon : icon,
                color: isSelected
                    ? AnimalColors.primary
                    : AnimalColors.textTertiary,
                size: Dimensions.iconMd,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isSelected
                    ? AnimalColors.primary
                    : AnimalColors.textTertiary,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
