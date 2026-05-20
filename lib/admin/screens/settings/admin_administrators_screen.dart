import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/admin_colors.dart';

class AdminAdministratorsScreen extends StatelessWidget {
  const AdminAdministratorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.background,
      appBar: AppBar(
        backgroundColor: AdminColors.background,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AdminColors.textPrimary), onPressed: () => context.pop()),
        title: const Text('Administrateurs', style: TextStyle(color: AdminColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          IconButton(icon: const Icon(Icons.person_add, color: AdminColors.primary), onPressed: () {})
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildAdminItem('Super Admin', 'admin@nafaedu.com', 'Super Admin'),
          _buildAdminItem('Modérateur 1', 'mod1@nafaedu.com', 'Modérateur'),
          _buildAdminItem('Support Technique', 'support@nafaedu.com', 'Support'),
        ],
      ),
    );
  }

  Widget _buildAdminItem(String name, String email, String role) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AdminColors.primary.withOpacity(0.1),
            child: const Icon(Icons.security, color: AdminColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AdminColors.textPrimary)),
                const SizedBox(height: 4),
                Text(email, style: const TextStyle(color: AdminColors.textSecondary, fontSize: 13)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: Colors.purple.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Text(role, style: const TextStyle(color: Colors.purple, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
