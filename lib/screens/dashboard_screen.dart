import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final stats = [
      _Stat(
        'Sujets traités',
        '24',
        Icons.menu_book_rounded,
        const Color(0xFFDBEAFE),
        const Color(0xFF2563EB),
      ),
      _Stat(
        'Moyenne',
        '14.5/20',
        Icons.emoji_events_rounded,
        const Color(0xFFD1FAE5),
        const Color(0xFF059669),
      ),
      _Stat(
        "Temps d'étude",
        '12h',
        Icons.schedule_rounded,
        const Color(0xFFEDE9FE),
        const Color(0xFF7C3AED),
      ),
      _Stat(
        'Progression',
        '+18%',
        Icons.trending_up_rounded,
        const Color(0xFFFED7AA),
        const Color(0xFFEA580C),
      ),
    ];

    final quickActions = [
      _QuickAction(
        'Banque de Sujets',
        Icons.menu_book_rounded,
        '/banque-sujets',
        AppColors.brand,
      ),
      _QuickAction(
        'Assistant IA',
        Icons.smart_toy_rounded,
        '/assistant',
        const Color(0xFF7C3AED),
      ),
      _QuickAction(
        'Forum',
        Icons.forum_rounded,
        '/forum',
        const Color(0xFF059669),
      ),
      _QuickAction(
        'Marketplace',
        Icons.shopping_bag_rounded,
        '/marketplace',
        const Color(0xFFEA580C),
      ),
    ];

    final recentActivity = [
      _Activity('Mathématiques', 'Sujet corrigé', 'Il y a 2h', '16/20'),
      _Activity('Physique-Chimie', 'Question posée', 'Il y a 5h', null),
      _Activity('Histoire-Géo', 'Sujet traité', 'Hier', '13/20'),
    ];

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: AppColors.brand,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: Text(
                        'JO',
                        style: TextStyle(
                          color: AppColors.brand,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jean Ouedraogo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'jean.ouedraogo@example.com',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'COMPTE',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 4),
              _DrawerItem(
                icon: Icons.person_outline_rounded,
                title: 'Mon Profil',
                onTap: (context) {
                  Navigator.of(context).pop();
                  context.go('/profil');
                },
              ),
              _DrawerItem(
                icon: Icons.settings_outlined,
                title: 'Paramètres',
                onTap: (context) {
                  Navigator.of(context).pop();
                  context.go('/parametres');
                },
              ),
              const Divider(height: 32, indent: 20, endIndent: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'SUPPORT',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 4),
              _DrawerItem(
                icon: Icons.help_outline_rounded,
                title: 'Aide',
                onTap: (context) {
                  Navigator.of(context).pop();
                  context.go('/aide');
                },
              ),
              _DrawerItem(
                icon: Icons.mail_outline_rounded,
                title: 'Contactez-nous',
                onTap: (context) {
                  Navigator.of(context).pop();
                  context.go('/contact');
                },
              ),
              const Divider(height: 32, indent: 20, endIndent: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'INFORMATIONS',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 4),
              _DrawerItem(
                icon: Icons.info_outline_rounded,
                title: 'À propos',
                onTap: (context) {
                  Navigator.of(context).pop();
                  context.go('/a-propos');
                },
              ),
              const Spacer(),
              _DrawerItem(
                icon: Icons.logout_rounded,
                title: 'Déconnexion',
                onTap: (context) {
                  Navigator.of(context).pop();
                  context.go('/auth/login');
                },
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Nafa Edu'),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Icon(Icons.school_rounded, color: AppColors.brand),
        ),
        actions: [
          IconButton(
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            icon: const Icon(Icons.more_vert_rounded),
          ),
          IconButton(
            onPressed: () => context.go('/profil'),
            icon: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.brand,
              child: Text(
                'JO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome
            Text(
              'Bienvenue, Jean !',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Voici un aperçu de votre progression',
              style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // Stats Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: stats
                  .map(
                    (s) => Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: s.bgColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(s.icon, color: s.iconColor, size: 20),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.value,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                s.label,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 28),

            // Quick Actions
            Text(
              'Accès rapide',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 14),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: quickActions
                  .map(
                    (a) => GestureDetector(
                      onTap: () => context.go(a.href),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: a.color,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: a.color.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(a.icon, color: Colors.white, size: 28),
                            Text(
                              a.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 28),

            // Recent Activity
            Text(
              'Activité récente',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: recentActivity.map((item) {
                  return Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: AppColors.brandLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.menu_book_rounded,
                            color: AppColors.brand,
                            size: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.subject,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                item.action,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Text(
                                item.time,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (item.score != null)
                          Text(
                            item.score!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.brand,
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 28),

            // Upcoming Exams
            Text(
              'Examens à venir',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  _ExamItem(
                    'BEPC Blanc',
                    'Toutes matières',
                    'Dans 5 jours',
                    const Color(0xFFEF4444),
                    const Color(0xFFFEF2F2),
                  ),
                  const SizedBox(height: 10),
                  _ExamItem(
                    'Devoir de Mathématiques',
                    'Chapitre 5 & 6',
                    'Dans 2 semaines',
                    const Color(0xFFF97316),
                    const Color(0xFFFFF7ED),
                  ),
                  const SizedBox(height: 10),
                  _ExamItem(
                    'Composition Française',
                    'Expression écrite',
                    'Dans 3 semaines',
                    const Color(0xFFEAB308),
                    const Color(0xFFFEFCE8),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Widget _ExamItem(
  String title,
  String subtitle,
  String time,
  Color accent,
  Color bg,
) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
      border: Border(left: BorderSide(color: accent, width: 4)),
    ),
    child: Row(
      children: [
        Icon(Icons.track_changes_rounded, color: accent, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              Text(
                time,
                style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _Stat {
  final String label, value;
  final IconData icon;
  final Color bgColor, iconColor;
  _Stat(this.label, this.value, this.icon, this.bgColor, this.iconColor);
}

class _QuickAction {
  final String title;
  final IconData icon;
  final String href;
  final Color color;
  _QuickAction(this.title, this.icon, this.href, this.color);
}

class _Activity {
  final String subject, action, time;
  final String? score;
  _Activity(this.subject, this.action, this.time, this.score);
}

Widget _DrawerItem({
  required IconData icon,
  required String title,
  required void Function(BuildContext) onTap,
}) {
  return Builder(
    builder: (context) {
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        leading: Icon(icon, color: AppColors.textPrimary),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, size: 20),
        onTap: () => onTap(context),
      );
    },
  );
}

Widget _InfoField(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      const SizedBox(height: 8),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}
