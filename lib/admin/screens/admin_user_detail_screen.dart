import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/admin_colors.dart';

class AdminUserDetailScreen extends StatelessWidget {
  const AdminUserDetailScreen({super.key});

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
        title: const Text('Détails utilisateur', style: TextStyle(color: AdminColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: AdminColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Jean Ouedraogo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AdminColors.textPrimary)),
                          const Text('Actif', style: TextStyle(color: AdminColors.success, fontWeight: FontWeight.bold, fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text('jean.ouedraogo@gmail.com', style: TextStyle(color: AdminColors.textSecondary, fontSize: 14)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: AdminColors.success.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                        child: const Text('Étudiant', style: TextStyle(color: AdminColors.success, fontWeight: FontWeight.bold, fontSize: 12)),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 32),

            // User Info
            _buildInfoRow(Icons.phone_outlined, 'Téléphone', '+226 70 12 34 56'),
            _buildInfoRow(Icons.calendar_today_outlined, 'Date d\'inscription', '12 Mars 2024'),
            _buildInfoRow(Icons.login_outlined, 'Dernière connexion', 'Aujourd\'hui à 09:45'),
            _buildInfoRow(Icons.school_outlined, 'Niveau', 'Terminale'),
            _buildInfoRow(Icons.verified_user_outlined, 'Statut du compte', 'Vérifié', valueColor: AdminColors.success),
            const SizedBox(height: 32),

            // Stats
            const Text('Statistiques', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AdminColors.textPrimary)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildStatCard('12', 'Sujets téléchargés', Icons.download_rounded, AdminColors.primary)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('8', 'Cours consultés', Icons.play_lesson_rounded, Colors.purple)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('24', 'Quiz réalisés', Icons.quiz_rounded, AdminColors.success)),
              ],
            ),
            const SizedBox(height: 48),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AdminColors.primary,
                      side: const BorderSide(color: AdminColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Désactiver le compte', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AdminColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Modifier', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, color: AdminColors.textSecondary, size: 20),
          const SizedBox(width: 16),
          Text(label, style: const TextStyle(color: AdminColors.textSecondary, fontSize: 14)),
          const Spacer(),
          Text(value, style: TextStyle(color: valueColor ?? AdminColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AdminColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AdminColors.textPrimary)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: AdminColors.textSecondary, height: 1.2)),
        ],
      ),
    );
  }
}
