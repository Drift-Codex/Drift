import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/admin_colors.dart';

class AdminShell extends StatelessWidget {
  final Widget child;
  const AdminShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();

    // Determine selected index based on route
    int selectedIndex = 0;
    if (currentRoute.startsWith('/admin/users')) {
      selectedIndex = 1;
    } else if (currentRoute.startsWith('/admin/content')) {
      selectedIndex = 2;
    } else if (currentRoute.startsWith('/admin/settings')) {
      selectedIndex = 3;
    }

    return Scaffold(
      backgroundColor: AdminColors.background,
      body: child,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers la création d'un sujet pour l'instant
          // Plus tard, ouvrir un BottomSheet pour choisir "Sujet" ou "Cours"
          context.push('/admin/create_subject');
        },
        backgroundColor: AdminColors.primary,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 10,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                icon: Icons.home_rounded,
                label: 'Accueil',
                isSelected: selectedIndex == 0,
                onTap: () => context.go('/admin/dashboard'),
              ),
              _buildNavItem(
                context,
                icon: Icons.people_alt_rounded,
                label: 'Utilisateurs',
                isSelected: selectedIndex == 1,
                onTap: () => context.go('/admin/users'),
              ),
              const SizedBox(width: 48), // Space for FAB
              _buildNavItem(
                context,
                icon: Icons.menu_book_rounded,
                label: 'Sujets',
                isSelected: selectedIndex == 2,
                onTap: () => context.go('/admin/content'),
              ),
              _buildNavItem(
                context,
                icon: Icons.settings_rounded,
                label: 'Paramètres',
                isSelected: selectedIndex == 3,
                onTap: () => context.go('/admin/settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, {
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final color = isSelected ? AdminColors.primary : Colors.grey.shade400;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
