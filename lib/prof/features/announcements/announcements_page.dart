import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/app_feedback.dart';
import 'publish_document_page.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mes Annonces',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PublishDocumentPage()),
                            );
                          },
                          child: const Icon(Icons.add, color: AppTheme.onPrimaryContainer),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // TabBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TabBar(
                  controller: _tabController,
                  labelColor: AppTheme.primary,
                  unselectedLabelColor: AppTheme.onSurfaceVariant,
                  labelStyle: Theme.of(context).textTheme.labelLarge,
                  unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
                  indicatorColor: AppTheme.primary,
                  indicatorWeight: 2,
                  dividerColor: AppTheme.outlineVariant,
                  tabs: const [
                    Tab(text: 'Actives'),
                    Tab(text: 'Archivées'),
                  ],
                ),
              ),

              // TabBarView Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Onglet Actives
                    ListView(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 120),
                      children: [
                        _buildAnnouncementCard(
                          context,
                          title: 'Annales Maths Terminale 2024',
                          status: 'Actif',
                          views: 45,
                          purchases: 12,
                          price: '1 500 FCFA',
                        ),
                        const SizedBox(height: 20),
                        _buildAnnouncementCard(
                          context,
                          title: 'Quiz Physique-Chimie 1ère D',
                          status: 'Actif',
                          views: 28,
                          purchases: 5,
                          price: '1 000 FCFA',
                        ),
                      ],
                    ),
                    // Onglet Archivées
                    const Center(
                      child: Text('Aucune annonce archivée', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // FAB flottant en bas à droite
        Positioned(
          bottom: 96,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PublishDocumentPage()),
              );
            },
            backgroundColor: AppTheme.primaryContainer,
            foregroundColor: AppTheme.onPrimaryContainer,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(Icons.add, size: 32),
          ),
        ),
      ],
    );
  }

  Widget _buildAnnouncementCard(
    BuildContext context, {
    required String title,
    required String status,
    required int views,
    required int purchases,
    required String price,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête de carte (Titre + Statut)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.tertiary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.tertiary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Statistiques
          Row(
            children: [
              Row(
                children: [
                  const Icon(Icons.visibility_outlined, size: 18, color: AppTheme.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Text('$views vues', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  const Icon(Icons.shopping_cart_outlined, size: 18, color: AppTheme.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Text('$purchases achats', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Prix
          Text(
            price,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(height: 16),

          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PublishDocumentPage()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: const BorderSide(color: AppTheme.primary),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Modifier', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    AppFeedback.confirm(
                      context,
                      title: 'Archiver l\'annonce ?',
                      message: '« $title » sera déplacée vers les annonces archivées (démo).',
                      confirmLabel: 'Archiver',
                      onConfirm: () {
                        AppFeedback.snackBar(context, 'Annonce archivée (démo).');
                      },
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.error,
                    side: const BorderSide(color: AppTheme.error),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Archiver', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
