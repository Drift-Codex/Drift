import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/admin_colors.dart';

class AdminCategoriesScreen extends StatelessWidget {
  const AdminCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.background,
      appBar: AppBar(
        backgroundColor: AdminColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AdminColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Gestion des catégories', style: TextStyle(color: AdminColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          IconButton(icon: const Icon(Icons.add, color: AdminColors.primary), onPressed: () {})
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildCategoryItem('Mathématiques', '156 sujets'),
          _buildCategoryItem('Physique', '84 sujets'),
          _buildCategoryItem('Chimie', '72 sujets'),
          _buildCategoryItem('SVT', '95 sujets'),
          _buildCategoryItem('Français', '110 sujets'),
          _buildCategoryItem('Histoire-Géographie', '64 sujets'),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String name, String count) {
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
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AdminColors.primary.withOpacity(0.1), shape: BoxShape.circle),
            child: const Icon(Icons.category, color: AdminColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AdminColors.textPrimary)),
                const SizedBox(height: 4),
                Text(count, style: const TextStyle(color: AdminColors.textSecondary, fontSize: 13)),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.edit, color: Colors.grey, size: 20), onPressed: () {}),
          IconButton(icon: const Icon(Icons.delete_outline, color: AdminColors.error, size: 20), onPressed: () {}),
        ],
      ),
    );
  }
}
