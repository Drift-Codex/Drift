import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../theme/app_theme.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  void _showPrivacyPolicy(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.brandLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.security_rounded,
                    color: AppColors.brand,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                const Text(
                  'Politique de Confidentialité',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPolicySection(
                      '1. Collecte des Données',
                      'Nous collectons des informations nécessaires à votre apprentissage et à la personnalisation de votre parcours, notamment votre nom, votre adresse e-mail, votre établissement et votre historique de consultation des sujets.',
                    ),
                    _buildPolicySection(
                      '2. Utilisation des Informations',
                      'Vos données sont uniquement utilisées pour vous fournir une banque de sujets d\'examens performante, vous permettre d\'interagir sur le forum et alimenter les recommandations personnalisées de notre assistant intelligent.',
                    ),
                    _buildPolicySection(
                      '3. Protection et Sécurité',
                      'Nous mettons en œuvre des mesures de sécurité rigoureuses pour protéger vos données contre tout accès, modification ou divulgation non autorisés. Vos identifiants de connexion sont hautement sécurisés.',
                    ),
                    _buildPolicySection(
                      '4. Vos Droits',
                      'Vous conservez un droit d\'accès, de modification et de suppression de vos données personnelles à tout moment, directement depuis les paramètres de votre compte ou en nous contactant.',
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Dernière mise à jour : Mai 2026',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.brand,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('J\'ai compris'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection(String title, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  void _showAllHistory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.brandLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.history_rounded,
                    color: AppColors.brand,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                const Text(
                  'Historique d\'activité',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildHistoryTile(
                    icon: Icons.calculate_rounded,
                    color: Colors.indigo,
                    title: 'Mathématiques - Sujet Blanc 2026',
                    time: 'Il y a 2h',
                  ),
                  _buildHistoryTile(
                    icon: Icons.biotech_rounded,
                    color: Colors.green,
                    title: 'SVT - Corrigé Brevet 2025',
                    time: 'Hier',
                  ),
                  _buildHistoryTile(
                    icon: Icons.science_rounded,
                    color: Colors.orange,
                    title: 'Physique - Exercices d\'optique',
                    time: 'Il y a 2j',
                  ),
                  _buildHistoryTile(
                    icon: Icons.history_edu_rounded,
                    color: Colors.purple,
                    title: 'Histoire - Quiz Révolution Française',
                    time: 'Il y a 4j',
                  ),
                  _buildHistoryTile(
                    icon: Icons.language_rounded,
                    color: Colors.blue,
                    title: 'Français - Fiche de révision Grammaire',
                    time: 'Il y a 1 semaine',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Fermer'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTile({
    required IconData icon,
    required Color color,
    required String title,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;
    final String fullName = user?.fullName ?? 'Jean Ouedraogo';
    final String initials = fullName.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join().toUpperCase();
    
    // Determine stylized level label
    String levelLabel = 'Étudiant - Université';
    if (user != null) {
      if (user.role == UserRole.teacher) {
        levelLabel = 'Enseignant';
      } else if (user.school.isNotEmpty) {
        levelLabel = 'Élève - ${user.school}';
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profil & Paramètres'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            onPressed: () => context.push('/a-propos'),
            tooltip: 'À propos',
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          return SafeArea(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 32.0 : 20.0,
                    vertical: 24.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // --- HEADER SECTION ---
                      Center(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.brand,
                                    AppColors.brand.withOpacity(0.4),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 48,
                                backgroundColor: Colors.white,
                                child: Text(
                                  initials.isNotEmpty ? initials : 'JO',
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.brand,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              fullName,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Stylized Badge (Chip/Pilule)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.brandLight,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.brand.withOpacity(0.15),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                levelLabel,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.brand,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // --- RESPONSIVE CONTENT ---
                      isWide
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _buildActivitySection(context),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: _buildMenuSection(context),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _buildActivitySection(context),
                                const SizedBox(height: 24),
                                _buildMenuSection(context),
                              ],
                            ),
                      const SizedBox(height: 32),

                      // --- FOOTER SECTION ---
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextButton.icon(
                            onPressed: () {
                              AuthService.logout();
                              context.go('/');
                            },
                            icon: const Icon(
                              Icons.logout_rounded,
                              size: 20,
                              color: Color(0xFFDC2626),
                            ),
                            label: const Text(
                              'Se déconnecter',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFDC2626),
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFFEE2E2),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: const Color(0xFFFECACA).withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- SECTION ACTIVITY ---
  Widget _buildActivitySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'Mes dernières activités',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: AppColors.border, width: 1),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildActivityTile(
                  icon: Icons.calculate_rounded,
                  color: Colors.indigo,
                  title: 'Mathématiques - Sujet Blanc 2026',
                  time: 'Il y a 2h',
                ),
                const Divider(height: 1, indent: 56, endIndent: 16),
                _buildActivityTile(
                  icon: Icons.biotech_rounded,
                  color: Colors.green,
                  title: 'SVT - Corrigé Brevet 2025',
                  time: 'Hier',
                ),
                const Divider(height: 1, indent: 56, endIndent: 16),
                _buildActivityTile(
                  icon: Icons.science_rounded,
                  color: Colors.orange,
                  title: 'Physique - Exercices d\'optique',
                  time: 'Il y a 2j',
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => _showAllHistory(context),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.brand,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Voir tout l\'historique',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityTile({
    required IconData icon,
    required Color color,
    required String title,
    required String time,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.chevron_right_rounded,
            size: 18,
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }

  // --- SECTION MENU/SUPPORT ---
  Widget _buildMenuSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'Support & Informations',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: AppColors.border, width: 1),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildMenuTile(
                  icon: Icons.help_outline_rounded,
                  title: 'Aide & FAQ',
                  onTap: () => context.push('/aide'),
                ),
                const Divider(height: 1, indent: 56, endIndent: 16),
                _buildMenuTile(
                  icon: Icons.alternate_email_rounded,
                  title: 'Nous contacter',
                  onTap: () => context.push('/contact'),
                ),
                const Divider(height: 1, indent: 56, endIndent: 16),
                _buildMenuTile(
                  icon: Icons.info_outline_rounded,
                  title: 'À propos de l\'application',
                  onTap: () => context.push('/a-propos'),
                ),
                const Divider(height: 1, indent: 56, endIndent: 16),
                _buildMenuTile(
                  icon: Icons.security_rounded,
                  title: 'Politique de confidentialité',
                  onTap: () => _showPrivacyPolicy(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.brandLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.brand, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        size: 20,
        color: AppColors.textTertiary,
      ),
      onTap: onTap,
    );
  }
}
