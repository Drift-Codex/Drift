import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/app_feedback.dart';
import '../../navigation/main_tab_scope.dart';

class DashboardPage extends StatelessWidget {
  final String teacherName;

  const DashboardPage({super.key, required this.teacherName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 32, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(context),
          const SizedBox(height: 32), // space-y-lg equivalent roughly
          _buildSummaryCards(context),
          const SizedBox(height: 32),
          _buildRecentActivity(context),
          const SizedBox(height: 32),
          _buildInsightsBanner(context),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bienvenue, Prof. $teacherName!',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 4), // mt-xs
        Text(
          'Voici ce qui se passe avec vos ressources aujourd\'hui.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildTappableCard(
            context,
            onTap: () => MainTabScope.maybeOf(context)?.goToTab(2),
            icon: Icons.description_outlined,
            iconBg: AppTheme.primary.withValues(alpha: 0.1),
            iconColor: AppTheme.primary,
            value: '154',
            label: 'Documents vendus',
          ),
        ),
        const SizedBox(width: 12), // gap-sm
        Expanded(
          child: _buildTappableCard(
            context,
            onTap: () => MainTabScope.maybeOf(context)?.goToTab(2),
            icon: Icons.payments_outlined,
            iconBg: AppTheme.primary,
            iconColor: Colors.white,
            value: '18,5k',
            label: 'Revenus ce mois',
            borderColor: AppTheme.primary.withValues(alpha: 0.2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildTappableCard(
            context,
            onTap: () => MainTabScope.maybeOf(context)?.goToTab(1),
            icon: Icons.campaign_outlined,
            iconBg: AppTheme.tertiaryFixed,
            iconColor: AppTheme.tertiary,
            value: '3',
            label: 'Annonces actives',
          ),
        ),
      ],
    );
  }

  Widget _buildTappableCard(
    BuildContext context, {
    required VoidCallback onTap,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String value,
    required String label,
    Color? borderColor,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: borderColor != null ? Border.all(color: borderColor) : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
              )
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(height: 4),
              Text(value, style: Theme.of(context).textTheme.displaySmall),
              Text(
                label.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Activité Récente',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            TextButton(
              onPressed: () => MainTabScope.maybeOf(context)?.goToTab(1),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Voir tout',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0x0D111111),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildActivityItem(
                context,
                icon: Icons.shopping_cart,
                iconBg: AppTheme.primary.withValues(alpha: 0.1),
                iconColor: AppTheme.primary,
                title: 'Vente : Math Grade 10',
                subtitle: 'Acheté par Sarah K. • il y a 2m',
                trailingWidget: Text(
                  '+€15.00',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.tertiary,
                  ),
                ),
              ),
              const Divider(height: 1, color: AppTheme.outlineVariant),
              _buildActivityItem(
                context,
                icon: Icons.chat_bubble_outline,
                iconBg: AppTheme.secondary.withValues(alpha: 0.1),
                iconColor: AppTheme.secondary,
                title: 'Commentaire sur Quiz Physique',
                subtitle: '"La réponse à la question 4 est-elle correcte ?" • il y a 1h',
                trailingWidget: IconButton(
                  icon: const Icon(Icons.reply, color: AppTheme.outline),
                  onPressed: () {
                    AppFeedback.snackBar(context, 'Réponse (démo) — bientôt disponible.');
                  },
                ),
              ),
              const Divider(height: 1, color: AppTheme.outlineVariant),
              _buildActivityItem(
                context,
                icon: Icons.visibility_outlined,
                iconBg: AppTheme.tertiary.withValues(alpha: 0.1),
                iconColor: AppTheme.tertiary,
                title: 'L\'annonce a été vue par 45 élèves',
                subtitle: 'Mise à jour "Calendrier Mi-parcours" • il y a 4h',
                trailingWidget: _buildAvatarStack(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(BuildContext context, {
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget trailingWidget,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          AppFeedback.snackBar(context, title);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              trailingWidget,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarStack() {
    return SizedBox(
      width: 56,
      height: 24,
      child: Stack(
        children: [
          Positioned(
            right: 32,
            child: _buildMiniAvatar(Colors.grey[300]!),
          ),
          Positioned(
            right: 16,
            child: _buildMiniAvatar(Colors.grey[400]!),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              alignment: Alignment.center,
              child: const Text(
                '+42',
                style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniAvatar(Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }

  Widget _buildInsightsBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E9FE), // secondary-fixed override in HTML
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meilleur document',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.onSecondaryFixed,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Votre guide \'Calcul Avancé\' est dans le top 5% des documents cette semaine !',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.onSecondaryFixedVariant,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => MainTabScope.maybeOf(context)?.goToTab(3),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5863F8), // bg-secondary override
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  elevation: 0,
                ),
                child: const Text('Voir stats', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          Positioned(
            right: -20,
            bottom: -30,
            child: Icon(
              Icons.trending_up,
              size: 120,
              color: AppTheme.onSecondaryFixed.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }
}
