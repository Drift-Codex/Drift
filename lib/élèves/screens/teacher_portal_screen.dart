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
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
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
                'Devenez Enseignant Certifié pour publier vos contenus et accéder au Marketplace.',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: currentUser.teacherRequestPending
                      ? Colors.orange.withOpacity(0.06)
                      : AppColors.brandLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: currentUser.teacherRequestPending
                        ? Colors.orange.withOpacity(0.2)
                        : AppColors.brand.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          currentUser.teacherRequestPending
                              ? Icons.hourglass_empty_rounded
                              : Icons.workspace_premium_rounded,
                          color: currentUser.teacherRequestPending ? Colors.orange : AppColors.brand,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          currentUser.teacherRequestPending
                              ? 'Demande en cours d\'analyse'
                              : 'Accès non demandé',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: currentUser.teacherRequestPending ? Colors.orange : AppColors.brand,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentUser.teacherRequestPending
                          ? 'Nos équipes vérifient vos pièces justificatives. Cette opération prend généralement moins de 48 heures.'
                          : 'Remplissez le formulaire de certification pour débloquer votre espace de publication.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              if (!currentUser.teacherRequestPending) ...[
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton.icon(
                    onPressed: () => context.push('/teacher-certification'),
                    icon: const Icon(Icons.workspace_premium_rounded),
                    label: const Text('Faire ma demande de certification'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.brand,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ] else if (currentUser.role != UserRole.teacher) ...[
              Text(
                'Votre accès professeur est approuvé. Vous pouvez activer le mode Professeur depuis votre profil.',
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
