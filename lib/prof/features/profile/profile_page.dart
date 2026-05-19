import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/app_feedback.dart';
import '../../navigation/main_tab_scope.dart';
import '../auth/auth_service.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;
    final fullName = user?['fullName'] as String? ?? 'Professeur';
    final subject = user?['subject'] as String? ?? 'Non définie';
    final email = user?['email'] as String? ?? 'Non renseigné';
    final school = user?['school'] as String? ?? 'Non renseigné';

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfileHeader(fullName, subject),
          const SizedBox(height: 32),
          _buildStatsGrid(context),
          const SizedBox(height: 32),
          _buildInfoSection(
            title: 'INFORMATIONS PERSONNELLES',
            children: [
              _buildInfoRow(Icons.mail_outline, 'Email', email),
              _buildInfoRow(Icons.phone_outlined, 'Téléphone', '+226 70 00 00 00'),
              _buildInfoRow(Icons.account_balance_outlined, 'Établissement', school, isLast: true),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoSection(
            title: 'PARAMÈTRES DU COMPTE',
            children: [
              _buildActionRow(
                context,
                Icons.edit_note,
                'Modifier le profil',
                onTap: () => AppFeedback.snackBar(context, 'Modification du profil (démo).'),
              ),
              _buildActionRow(
                context,
                Icons.shield_outlined,
                'Sécurité',
                onTap: () => AppFeedback.snackBar(context, 'Sécurité du compte (démo).'),
              ),
              _buildActionRow(
                context,
                Icons.notifications_active_outlined,
                'Notifications',
                isLast: true,
                onTap: () => AppFeedback.snackBar(context, 'Préférences de notifications (démo).'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoSection(
            title: 'SUPPORT & LÉGAL',
            children: [
              _buildActionRow(
                context,
                Icons.help_center_outlined,
                'Aide',
                onTap: () => AppFeedback.helpDialog(context),
              ),
              _buildActionRow(
                context,
                Icons.gavel_outlined,
                'Conditions d\'utilisation',
                onTap: () => AppFeedback.snackBar(context, 'CGU (démo) — document à intégrer.'),
              ),
              _buildActionRow(
                context,
                Icons.logout,
                'Déconnexion',
                isDestructive: true,
                isLast: true,
                onTap: () {
                  AuthService.logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(String fullName, String subject) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                  )
                ],
                image: DecorationImage(
                  image: NetworkImage(
                      'https://ui-avatars.com/api/?name=${Uri.encodeComponent(fullName)}&background=random&size=128'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.verified,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          fullName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.onSurface,
            letterSpacing: -0.01,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Professeur de $subject',
          style: const TextStyle(
            fontSize: 16,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.tertiary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.verified_user,
                color: AppTheme.tertiary,
                size: 14,
              ),
              SizedBox(width: 4),
              Text(
                'Compte Vérifié',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.tertiary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => MainTabScope.maybeOf(context)?.goToTab(2),
              child: Container(
                height: 140,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'SOLDE DU PORTEFEUILLE',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.onSurfaceVariant,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '125.000 FCFA',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                        letterSpacing: -0.02,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      'Gérer mes revenus',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primary,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: AppTheme.primary,
                    ),
                  ],
                ),
              ],
            ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => MainTabScope.maybeOf(context)?.goToTab(3),
              child: Container(
                height: 140,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'COURS DONNÉS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.onSecondaryContainer.withValues(alpha: 0.8),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '482',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.onSecondaryContainer,
                        letterSpacing: -0.01,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.school,
                  size: 48,
                  color: AppTheme.onSecondaryContainer.withValues(alpha: 0.3),
                ),
              ],
            ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection({required String title, required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(
              color: AppTheme.surfaceContainerLow,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.onSurfaceVariant,
                letterSpacing: 0.5,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: isLast ? null : Border(bottom: BorderSide(color: AppTheme.outlineVariant.withValues(alpha: 0.3))),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primary, size: 24),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppTheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow(
    BuildContext context,
    IconData icon,
    String label, {
    required VoidCallback onTap,
    bool isDestructive = false,
    bool isLast = false,
  }) {
    final color = isDestructive ? AppTheme.error : AppTheme.primary;
    final textColor = isDestructive ? AppTheme.error : AppTheme.onSurface;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: isLast ? null : Border(bottom: BorderSide(color: AppTheme.outlineVariant.withValues(alpha: 0.3))),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: isDestructive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
              if (!isDestructive)
                const Icon(
                  Icons.chevron_right,
                  color: AppTheme.outline,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
