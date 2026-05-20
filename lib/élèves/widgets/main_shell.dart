import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/forum')) return 1;
    if (location.startsWith('/quiz')) return 2;
    if (location.startsWith('/marketplace')) return 3;
    if (location.startsWith('/profil-parametres') ||
        location.startsWith('/banque-sujets'))
      return 4;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/forum');
        break;
      case 2:
        context.go('/quiz');
        break;
      case 3:
        context.go('/marketplace');
        break;
      case 4:
        context.go('/profil-parametres');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0FF).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(
                      iconOutlined: Icons.home_outlined,
                      iconFilled: Icons.home,
                      label: 'Accueil',
                      isActive: selectedIndex == 0,
                      onTap: () => _onItemTapped(context, 0),
                    ),
                    _NavItem(
                      iconOutlined: Icons.forum_outlined,
                      iconFilled: Icons.forum,
                      label: 'Forum',
                      isActive: selectedIndex == 1,
                      onTap: () => _onItemTapped(context, 1),
                    ),
                    _NavItem(
                      iconOutlined: Icons.quiz_outlined,
                      iconFilled: Icons.quiz,
                      label: 'Quiz',
                      isActive: selectedIndex == 2,
                      onTap: () => _onItemTapped(context, 2),
                    ),
                    _NavItem(
                      iconOutlined: Icons.storefront_outlined,
                      iconFilled: Icons.storefront,
                      label: 'Marketplace',
                      isActive: selectedIndex == 3,
                      onTap: () => _onItemTapped(context, 3),
                    ),
                    _NavItem(
                      iconOutlined: Icons.person_outline_rounded,
                      iconFilled: Icons.person_rounded,
                      label: 'Profil',
                      isActive: selectedIndex == 4,
                      onTap: () => _onItemTapped(context, 4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData iconOutlined;
  final IconData iconFilled;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.iconOutlined,
    required this.iconFilled,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = AppColors.brand;
    final Color inactiveColor = AppColors.textTertiary.withOpacity(0.6);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: isActive
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 6)
            : const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? iconFilled : iconOutlined,
              color: isActive ? activeColor : inactiveColor,
              size: 20,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: isActive ? FontWeight.w500 : FontWeight.w300,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
