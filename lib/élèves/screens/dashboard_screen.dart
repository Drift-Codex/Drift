import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Mes Statistiques'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: () {},
            tooltip: 'Partager le profil',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vue d’ensemble de mon activité',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Suivez votre participation au forum et vos consultations.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 24),

            // Section Mes Statistiques
            Row(
              children: [
                Expanded(
                  child: _StatSummaryCard(
                    icon: Icons.chat_rounded,
                    label: 'Questions posées',
                    value: '12',
                    color: Color(0xFF6366F1),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatSummaryCard(
                    icon: Icons.forum_rounded,
                    label: 'Réponses données',
                    value: '34',
                    color: Color(0xFF10B981),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatSummaryCard(
                    icon: Icons.thumb_up_alt_rounded,
                    label: 'Réactions reçues',
                    value: '145',
                    color: Color(0xFFF59E0B),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatSummaryCard(
                    icon: Icons.visibility_rounded,
                    label: 'Sujets consultés',
                    value: '89',
                    color: Color(0xFF8B5CF6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            _SectionHeader(title: 'Derniers sujets visionnés', actionLabel: 'Voir tout', onAction: () {}),
            const SizedBox(height: 16),
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _ViewedSubjectCard(subject: 'Mathématiques', title: 'Théorème de Pythagore', timeAgo: 'Il y a 2h', icon: Icons.calculate_rounded),
                  _ViewedSubjectCard(subject: 'SVT', title: 'La photosynthèse', timeAgo: 'Hier', icon: Icons.biotech_rounded),
                  _ViewedSubjectCard(subject: 'Physique', title: 'Lois de Newton', timeAgo: 'Il y a 2j', icon: Icons.science_rounded),
                  _ViewedSubjectCard(subject: 'Histoire', title: 'Révolution Française', timeAgo: 'La semaine dernière', icon: Icons.history_edu_rounded),
                ],
              ),
            ),
            const SizedBox(height: 32),

            _SectionHeader(title: 'Mon activité récente', actionLabel: 'Filtrer', onAction: () {}),
            const SizedBox(height: 16),
            const _ActivityTile(
              icon: Icons.question_answer_rounded,
              title: 'Vous avez répondu à une question',
              subtitle: '« Difficulté avec les équations du second degré » en Mathématiques.',
              timeAgo: 'Il y a 4h',
            ),
            const SizedBox(height: 12),
            const _ActivityTile(
              icon: Icons.thumb_up_rounded,
              title: 'On a aimé votre réponse',
              subtitle: 'Fatou S. a aimé votre réponse sur « Photosynthèse - éclaircissements ».',
              timeAgo: 'Hier',
            ),
            const SizedBox(height: 12),
            const _ActivityTile(
              icon: Icons.post_add_rounded,
              title: 'Vous avez posé une question',
              subtitle: '« Comment structurer une introduction ? » en Français.',
              timeAgo: 'Il y a 3j',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback onAction;

  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        TextButton(
          onPressed: onAction,
          child: Text(actionLabel, style: TextStyle(color: AppColors.brand, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}

class _StatSummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatSummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _ViewedSubjectCard extends StatelessWidget {
  final String subject;
  final String title;
  final String timeAgo;
  final IconData icon;

  const _ViewedSubjectCard({
    required this.subject,
    required this.title,
    required this.timeAgo,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.brand, size: 20),
              const SizedBox(width: 8),
              Text(
                subject,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.brand,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          const Spacer(),
          Text(
            timeAgo,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String timeAgo;

  const _ActivityTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.textPrimary, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(timeAgo, style: TextStyle(fontSize: 12, color: AppColors.textTertiary)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(subtitle, style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
