import 'package:flutter/material.dart';
import '../theme/admin_colors.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Vue d\'ensemble',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AdminColors.textPrimary),
                      ),
                      Row(
                        children: [
                          const Text('Aujourd\'hui', style: TextStyle(color: AdminColors.textSecondary, fontSize: 14)),
                          const SizedBox(width: 4),
                          const Icon(Icons.keyboard_arrow_down, color: AdminColors.textSecondary, size: 20),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.15,
                    children: [
                      _buildStatCard('Utilisateurs', '1,248', Icons.people_alt_rounded, '+12%', Colors.blue.shade400),
                      _buildStatCard('Sujets', '342', Icons.description_rounded, '+8%', Colors.orange.shade400),
                      _buildStatCard('Cours', '156', Icons.play_lesson_rounded, '+15%', Colors.purple.shade400),
                      _buildStatCard('Catégories', '24', Icons.category_rounded, '+3%', Colors.red.shade400),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Activité récente',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AdminColors.textPrimary),
                      ),
                      Text('Voir tout', style: TextStyle(color: AdminColors.primary, fontWeight: FontWeight.w600, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildActivityItem('Nouveau sujet ajouté', 'Mathématiques - Terminale', 'il y a 2 min', Icons.check_circle_outline, AdminColors.primary),
                  _buildActivityItem('Nouvel utilisateur inscrit', 'user123@gmail.com', 'il y a 5 min', Icons.person_outline, Colors.blue),
                  _buildActivityItem('Cours mis à jour', 'Physique - Première', 'il y a 15 min', Icons.update, Colors.orange),
                  _buildActivityItem('Sujet approuvé', 'Français - Brevet', 'il y a 30 min', Icons.verified_outlined, AdminColors.success),
                  const SizedBox(height: 80), // Padding for bottom nav
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
      decoration: const BoxDecoration(
        color: AdminColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.menu, color: Colors.white),
              Stack(
                children: [
                  const Icon(Icons.notifications_none, color: Colors.white, size: 28),
                  Positioned(
                    right: 2,
                    top: 2,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Bonjour, Admin 👋',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tableau de bord',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, String trend, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AdminColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: iconColor, size: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AdminColors.successLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  trend,
                  style: const TextStyle(color: AdminColors.success, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AdminColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 13, color: AdminColors.textSecondary, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String time, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AdminColors.textPrimary)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: AdminColors.textSecondary, fontSize: 13)),
              ],
            ),
          ),
          Text(time, style: TextStyle(color: AdminColors.textSecondary.withOpacity(0.7), fontSize: 12)),
        ],
      ),
    );
  }
}
