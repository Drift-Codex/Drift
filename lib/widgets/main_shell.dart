import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/banque-sujets')) return 1;
    if (location.startsWith('/assistant')) return 2;
    if (location.startsWith('/forum')) return 3;
    if (location.startsWith('/marketplace')) return 4;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/banque-sujets');
        break;
      case 2:
        context.go('/assistant');
        break;
      case 3:
        context.go('/forum');
        break;
      case 4:
        context.go('/marketplace');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    icon: Icons.home_rounded,
                    label: 'Accueil',
                    isActive: selectedIndex == 0,
                    onTap: () => _onItemTapped(context, 0),
                  ),
                  _NavItem(
                    icon: Icons.menu_book_rounded,
                    label: 'Sujets',
                    isActive: selectedIndex == 1,
                    onTap: () => _onItemTapped(context, 1),
                  ),
                  _NavItem(
                    icon: Icons.smart_toy_rounded,
                    label: 'Assistant',
                    isActive: selectedIndex == 2,
                    onTap: () => _onItemTapped(context, 2),
                  ),
                  _NavItem(
                    icon: Icons.forum_rounded,
                    label: 'Forum',
                    isActive: selectedIndex == 3,
                    onTap: () => _onItemTapped(context, 3),
                  ),
                  _NavItem(
                    icon: Icons.shopping_bag_rounded,
                    label: 'Market',
                    isActive: selectedIndex == 4,
                    onTap: () => _onItemTapped(context, 4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.brand : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isActive ? Colors.white : AppColors.textTertiary,
            ),
            if (isActive) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
