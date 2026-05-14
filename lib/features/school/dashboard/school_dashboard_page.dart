import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/app_feedback.dart';
import '../campaigns/create_campaign_page.dart';

/// Ferme toute la pile « école » et revient à l’écran professeur (racine du navigateur).
void _exitToTeacherPortal(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
}

void _showCampaignActions(BuildContext context, String title) {
  showModalBottomSheet<void>(
    context: context,
    builder: (ctx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Modifier'),
            onTap: () {
              Navigator.pop(ctx);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateCampaignPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.pause_circle_outline),
            title: const Text('Mettre en pause'),
            onTap: () {
              Navigator.pop(ctx);
              AppFeedback.snackBar(context, 'Campagne mise en pause (démo) : $title');
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart_outlined),
            title: const Text('Voir les statistiques'),
            onTap: () {
              Navigator.pop(ctx);
              AppFeedback.snackBar(context, 'Statistiques de : $title');
            },
          ),
        ],
      ),
    ),
  );
}

class SchoolDashboardPage extends StatelessWidget {
  const SchoolDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acces ecole'),
        backgroundColor: AppTheme.surface,
        actions: [
          TextButton.icon(
            onPressed: () => _exitToTeacherPortal(context),
            icon: const Icon(Icons.logout, size: 18, color: AppTheme.primary),
            label: const Text('Portail professeur'),
            style: TextButton.styleFrom(foregroundColor: AppTheme.primary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 32, bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(context),
            const SizedBox(height: 32),
            _buildSummaryCards(context),
            const SizedBox(height: 32),
            _buildQuickActions(context),
            const SizedBox(height: 32),
            _buildActiveCampaigns(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bienvenue, Admin',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 4),
        Text(
          'Voici l\'apercu de l\'activite de votre etablissement aujourd\'hui.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards(BuildContext context) {
    return Column(
      children: [
        _buildStatCard(
          context,
          icon: Icons.visibility_outlined,
          accentColor: AppTheme.primary,
          trendText: '+12%',
          value: '24,842',
          label: 'Vues totales des pubs',
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          context,
          icon: Icons.person_add_alt_1,
          accentColor: AppTheme.secondary,
          trendText: '+5%',
          value: '156',
          label: 'Candidatures recues',
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          context,
          icon: Icons.description_outlined,
          accentColor: AppTheme.tertiary,
          trendText: 'Stable',
          value: '42',
          label: 'Documents publies',
          stable: true,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required Color accentColor,
    required String trendText,
    required String value,
    required String label,
    bool stable = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: accentColor, width: 4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D111111),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 30, color: accentColor),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: stable
                      ? AppTheme.surfaceVariant
                      : AppTheme.tertiary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  trendText,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: stable ? AppTheme.onSurfaceVariant : AppTheme.tertiary,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                  letterSpacing: 0.8,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Actions Rapides', style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _buildActionButton(
              context,
              label: 'Creer une campagne',
              icon: Icons.add_circle_outline,
              filled: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateCampaignPage()),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    bool filled = false,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: 240,
      height: 48,
      child: filled
          ? ElevatedButton.icon(
              onPressed: onPressed ??
                  () {
                    AppFeedback.snackBar(context, 'Action : $label');
                  },
              icon: Icon(icon, size: 20),
              label: Text(label),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: AppTheme.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            )
          : OutlinedButton.icon(
              onPressed: onPressed ??
                  () {
                    AppFeedback.snackBar(context, 'Action : $label');
                  },
              icon: Icon(icon, size: 20),
              label: Text(label),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.primary,
                side: const BorderSide(color: AppTheme.primary),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
    );
  }

  Widget _buildActiveCampaigns(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Campagnes actives', style: Theme.of(context).textTheme.displaySmall),
            TextButton.icon(
              onPressed: () {
                AppFeedback.snackBar(context, 'Liste complète des campagnes (démo).');
              },
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward, size: 16),
              label: const Text('Voir tout'),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.primary,
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildCampaignCard(
          context,
          icon: Icons.campaign_outlined,
          iconColor: AppTheme.primary,
          iconBackground: AppTheme.primary.withValues(alpha: 0.1),
          title: 'Recrutement Professeurs de Mathematiques',
          subtitle: 'Publie il y a 2 jours - 24 candidatures',
          progress: 0.65,
          status: 'ACTIF',
          isActive: true,
        ),
        const SizedBox(height: 12),
        _buildCampaignCard(
          context,
          icon: Icons.school_outlined,
          iconColor: AppTheme.secondary,
          iconBackground: AppTheme.secondary.withValues(alpha: 0.1),
          title: 'Inscriptions Rentree Scolaire 2024',
          subtitle: 'Publie il y a 1 semaine - 1,204 vues',
          progress: 0.85,
          status: 'ACTIF',
          isActive: true,
        ),
        const SizedBox(height: 12),
        _buildCampaignCard(
          context,
          icon: Icons.event_outlined,
          iconColor: AppTheme.onSurfaceVariant,
          iconBackground: AppTheme.surfaceVariant,
          title: 'Conference Orientation Parent-Eleve',
          subtitle: 'Prevu pour le 15 Octobre - 45 inscrits',
          progress: 0.30,
          status: 'BROUILLON',
          isActive: false,
        ),
      ],
    );
  }

  Widget _buildCampaignCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    required String subtitle,
    required double progress,
    required String status,
    required bool isActive,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D111111),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: AppTheme.surfaceContainer,
                    color: isActive ? AppTheme.primary : AppTheme.outlineVariant,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppTheme.tertiary.withValues(alpha: 0.12)
                      : AppTheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  status,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isActive ? AppTheme.tertiary : AppTheme.onSurfaceVariant,
                      ),
                ),
              ),
              IconButton(
                onPressed: () => _showCampaignActions(context, title),
                icon: const Icon(Icons.more_vert),
                color: AppTheme.onSurfaceVariant,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
