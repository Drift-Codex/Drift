import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/admin_colors.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.background,
      appBar: AppBar(
        backgroundColor: AdminColors.background,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Paramètres',
          style: TextStyle(color: AdminColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Général'),
            _buildSettingsGroup([
              _buildSettingsRow(context, Icons.business, 'Informations de la plateforme', onTap: () => context.push('/admin/settings/platform_info')),
              _buildSettingsRow(context, Icons.category, 'Gestion des catégories', onTap: () => context.push('/admin/settings/categories')),
              _buildSettingsRow(context, Icons.public, 'Réseaux sociaux', onTap: () => context.push('/admin/settings/social_links'), isLast: true),
            ]),
            const SizedBox(height: 24),
            _buildSectionTitle('Sécurité'),
            _buildSettingsGroup([
              _buildSettingsRow(context, Icons.shield_outlined, 'Administrateurs', onTap: () => context.push('/admin/settings/administrators')),
              _buildSettingsRow(context, Icons.key, 'Permissions', onTap: () => context.push('/admin/settings/permissions')),
              _buildSettingsRow(context, Icons.backup, 'Sauvegarde et restauration', onTap: () => context.push('/admin/settings/backup'), isLast: true),
            ]),
            const SizedBox(height: 24),
            _buildSectionTitle('Autre'),
            _buildSettingsGroup([
              _buildSettingsRow(context, Icons.notifications_none, 'Notifications', onTap: () => context.push('/admin/settings/notifications')),
              _buildSettingsRow(context, Icons.info_outline, 'À propos de l\'application', onTap: () => context.push('/admin/settings/about')),
              _buildSettingsRow(context, Icons.logout, 'Déconnexion', isDestructive: true, isLast: true, onTap: () => _showLogoutDialog(context)),
            ]),
            const SizedBox(height: 80), // Padding for BottomNav
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: AdminColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AdminColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsRow(BuildContext context, IconData icon, String title, {bool isDestructive = false, bool isLast = false, required VoidCallback onTap}) {
    Color color = isDestructive ? AdminColors.error : AdminColors.textPrimary;
    Color iconColor = isDestructive ? AdminColors.error : AdminColors.primary.withOpacity(0.7);

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Icon(icon, color: iconColor),
          title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 15)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          onTap: onTap,
        ),
        if (!isLast)
          const Divider(height: 1, thickness: 1, indent: 56, endIndent: 16, color: Color(0xFFF1F5F9)),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter de l\'administration ?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Annuler', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              // Naviguer vers la sélection ou le login
              context.go('/auth/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AdminColors.error,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Se déconnecter', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
