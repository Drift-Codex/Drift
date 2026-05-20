import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/admin_colors.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.background,
      appBar: AppBar(
        backgroundColor: AdminColors.background,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Utilisateurs',
          style: TextStyle(color: AdminColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AdminColors.textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: AdminColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                _buildTab('Tous', true),
                _buildTab('Étudiants', false),
                _buildTab('Enseignants', false),
                _buildTab('Autres', false),
              ],
            ),
          ),
          // Subheader
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('1,248 utilisateurs', style: TextStyle(color: AdminColors.textSecondary, fontSize: 14)),
                Row(
                  children: [
                    const Text('Trier par', style: TextStyle(color: AdminColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down, size: 20),
                  ],
                ),
              ],
            ),
          ),
          // List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              children: [
                _buildUserItem(context, 'Jean Ouedraogo', 'jean.ouedraogo@gmail.com', 'Étudiant', true),
                _buildUserItem(context, 'Awa Traoré', 'awa01@gmail.com', 'Étudiant', true),
                _buildUserItem(context, 'Moussa Diallo', 'moussa.diallo@gmail.com', 'Enseignant', false),
                _buildUserItem(context, 'Fatou Sissoko', 'fatou.sissoko@gmail.com', 'Étudiant', true),
                _buildUserItem(context, 'Boubacar Kaboré', 'b.kabore@gmail.com', 'Enseignant', false),
                _buildUserItem(context, 'Aminata Sawadogo', 'amina.sawadogo@gmail.com', 'Étudiant', true),
                _buildUserItem(context, 'Issa Zongo', 'issa.zongo@gmail.com', 'Autre', false, isInactive: true),
                const SizedBox(height: 80), // Padding for BottomNav
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AdminColors.primary.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isSelected ? AdminColors.primary : Colors.grey.shade300),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? AdminColors.primary : AdminColors.textSecondary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildUserItem(BuildContext context, String name, String email, String role, bool isStudent, {bool isInactive = false}) {
    Color roleColor = isStudent ? AdminColors.success : Colors.blue;
    if (isInactive) roleColor = Colors.grey;

    return GestureDetector(
      onTap: () => context.push('/admin/user_detail'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AdminColors.card,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AdminColors.primary.withOpacity(0.1),
              child: Text(name.substring(0, 1), style: const TextStyle(color: AdminColors.primary, fontWeight: FontWeight.bold, fontSize: 18)),
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
              decoration: BoxDecoration(
                color: roleColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                role,
                style: TextStyle(color: roleColor, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            if (isInactive) ...[
              const SizedBox(width: 8),
              const Icon(Icons.block, color: Colors.grey, size: 16),
            ],
            const SizedBox(width: 8),
            const Icon(Icons.more_vert, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
