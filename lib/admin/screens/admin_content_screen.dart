import 'package:flutter/material.dart';
import '../theme/admin_colors.dart';

class AdminContentScreen extends StatelessWidget {
  const AdminContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.background,
      appBar: AppBar(
        backgroundColor: AdminColors.background,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Sujets',
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
                _buildTab('Approuvés', false),
                _buildTab('En attente', false),
                _buildTab('Rejetés', false),
              ],
            ),
          ),
          // Subheader
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('342 sujets', style: TextStyle(color: AdminColors.textSecondary, fontSize: 14)),
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
                _buildSubjectItem('Mathématiques - Terminale', 'Algèbre - Équations', 'Approuvé', AdminColors.primary),
                _buildSubjectItem('Français - Première', 'Dissertation - La poésie', 'Approuvé', Colors.orange),
                _buildSubjectItem('Physique - Terminale', 'Mécanique - Les forces', 'En attente', Colors.purple),
                _buildSubjectItem('SVT - Seconde', 'La cellule', 'Approuvé', Colors.green),
                _buildSubjectItem('Chimie - Première', 'Les solutions acides', 'Rejeté', Colors.red),
                _buildSubjectItem('Histoire - Terminale', 'La seconde guerre mondiale', 'Approuvé', Colors.blue),
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

  Widget _buildSubjectItem(String title, String subtitle, String status, Color iconBgColor) {
    Color statusColor = AdminColors.success;
    if (status == 'En attente') statusColor = AdminColors.warning;
    if (status == 'Rejeté') statusColor = AdminColors.error;

    return Container(
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
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: iconBgColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.description_rounded, color: iconBgColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AdminColors.textPrimary)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: AdminColors.textSecondary, fontSize: 13)),
                const SizedBox(height: 4),
                const Text('PDF', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Text(
            status,
            style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
