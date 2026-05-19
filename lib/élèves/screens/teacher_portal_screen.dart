import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nafa_edu/models/user.dart';
import '../../services/auth_service.dart';
import '../theme/app_theme.dart';

class TeacherPortalScreen extends StatelessWidget {
  const TeacherPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService.currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text('Espace Professeur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mode professeur',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            if (currentUser == null) ...[
              Text(
                'Connectez-vous pour activer le mode professeur.',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => context.go('/auth/login'),
                child: const Text('Se connecter'),
              ),
            ] else if (!currentUser.teacherAccessApproved) ...[
              Text(
                'Votre demande d’accès professeur n’est pas encore approuvée.',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),
              Text(
                currentUser.teacherRequestPending
                    ? 'Statut : demande en attente'
                    : 'Statut : accès professeur non demandé',
                style: TextStyle(fontSize: 16, color: AppColors.brand),
              ),
            ] else if (currentUser.role != UserRole.teacher) ...[
              Text(

                'Votre accès professeur est approuvé Vous pouvez activer le mode Professeur depuis votre profil.',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
            ] else ...[
              Text(
                'Bienvenue dans votre espace professeur !',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),
              _TeacherFeatureCard(
                icon: Icons.school_rounded,
                title: 'Tableau de bord professeur',
                subtitle: 'Accédez aux fonctions pédagogiques dédiées.',
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TeacherFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _TeacherFeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.brand, size: 32),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    )),
                const SizedBox(height: 6),
                Text(subtitle,
                    style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
