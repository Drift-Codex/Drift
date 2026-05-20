import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/admin_colors.dart';

class AdminBackupScreen extends StatelessWidget {
  const AdminBackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.background,
      appBar: AppBar(
        backgroundColor: AdminColors.background,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AdminColors.textPrimary), onPressed: () => context.pop()),
        title: const Text('Sauvegarde et restauration', style: TextStyle(color: AdminColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: AdminColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  const Icon(Icons.cloud_done, color: AdminColors.primary, size: 48),
                  const SizedBox(height: 16),
                  const Text('Dernière sauvegarde', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  const Text('Aujourd\'hui à 04:00 AM (45 Mo)', style: TextStyle(color: AdminColors.textSecondary)),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: AdminColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      child: const Text('Créer une sauvegarde maintenant', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Historique des sauvegardes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            _buildBackupItem('Sauvegarde automatique', 'Hier à 04:00 AM', '44.5 Mo'),
            _buildBackupItem('Sauvegarde manuelle', '18 Mai 2024', '42.1 Mo'),
            _buildBackupItem('Sauvegarde automatique', '17 Mai 2024', '41.8 Mo'),
          ],
        ),
      ),
    );
  }

  Widget _buildBackupItem(String title, String date, String size) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          const Icon(Icons.backup_table, color: Colors.grey),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(date, style: const TextStyle(color: AdminColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Text(size, style: const TextStyle(color: AdminColors.textSecondary, fontWeight: FontWeight.bold)),
          const SizedBox(width: 16),
          const Icon(Icons.restore, color: AdminColors.primary),
        ],
      ),
    );
  }
}
