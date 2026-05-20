import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import 'post_detail_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/promo_carousel.dart';

import '../../services/auth_service.dart';

class _FeedItem {
  final String author;
  final String username;
  final String title;
  final String description;
  final String imageUrl;
  final String timeAgo;
  final double aspectRatio;
  final String level;

  const _FeedItem({
    required this.author,
    required this.username,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.timeAgo,
    required this.aspectRatio,
    required this.level,
  });
}

class ExamBankScreen extends StatefulWidget {
  const ExamBankScreen({super.key});

  @override
  State<ExamBankScreen> createState() => _ExamBankScreenState();
}

class _ExamBankScreenState extends State<ExamBankScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedLevel;

  final List<String> _levels = ['Primaire', 'Collège', 'Lycée', 'Université'];

  List<PromoCardModel> _buildPromoCards(BuildContext context) {
    return [
      PromoCardModel(
        badgeText: 'Nouveauté',
        icon: Icons.workspace_premium_rounded,
        title: 'Devenir Super Utilisateur 🌟',
        description: 'Aidez la communauté en validant les corrections de sujets et gagnez des points.',
        buttonText: 'Faire ma demande',
        gradientColors: [const Color(0xFF6366F1), const Color(0xFF4F46E5)],
        onTap: () {
          if (AuthService.requireLogin(context, action: 'faire une demande')) {
            context.push('/teacher-certification');
          }
        },
      ),
      PromoCardModel(
        badgeText: 'Sponsorisé',
        icon: Icons.school_rounded,
        title: 'Formations Premium Nafa 🚀',
        description: 'Bénéficiez de 30% de réduction sur nos séances intensives de soutien scolaire.',
        buttonText: 'En savoir plus 🌐',
        gradientColors: [const Color(0xFF06B6D4), const Color(0xFF0891B2)],
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Text('Nafa Academy Premium'),
              content: const Text(
                'Visitez le site internet de Nafa Academy pour vous inscrire à nos cours d\'excellence et débloquer les examens corrigés avec nos tuteurs certifiés.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Super !'),
                ),
              ],
            ),
          );
        },
      ),
      PromoCardModel(
        badgeText: 'Quiz',
        icon: Icons.quiz_rounded,
        title: 'Évaluez vos compétences 📝',
        description: 'Découvrez nos quiz interactifs QCM en Mathématiques, SVT et Physique.',
        buttonText: 'Démarrer un test',
        gradientColors: [const Color(0xFFEC4899), const Color(0xFFDB2777)],
        onTap: () {
          context.go('/quiz');
        },
      ),
    ];
  }

  late final List<_FeedItem> _feedItems;

  @override
  void initState() {
    super.initState();
    _feedItems = List.from(allItems);
  }

  static const List<_FeedItem> allItems = [
    _FeedItem(
      author: 'Aminata O.',
      username: '@aminata',
      title: 'Astuce rapide : réussir les transformations algébriques',
      description:
          'Un guide visuel et simple pour transformer les équations sans stress.',
      imageUrl: 'assets/image/sujet1.jpg',
      timeAgo: '12 min',
      aspectRatio: 4 / 5,
      level: 'Lycée',
    ),
    _FeedItem(
      author: 'Ibrahim K.',
      username: '@ibrahim',
      title: 'Révision express : les lois de Newton',
      description:
          'Des exemples faciles à relire avant l’examen du prochain jour.',
      imageUrl: 'assets/image/sujet2.jpg',
      timeAgo: '45 min',
      aspectRatio: 1,
      level: 'Lycée',
    ),
    _FeedItem(
      author: 'Fatou S.',
      username: '@fatou',
      title: 'Fiches de synthèse : Photosynthèse et respiration',
      description:
          'Un support visuel clair pour retenir les étapes principales.',
      imageUrl: 'assets/image/Sujet3.jpg',
      timeAgo: '1 h',
      aspectRatio: 4 / 5,
      level: 'Collège',
    ),
    _FeedItem(
      author: 'Moussa T.',
      username: '@moussa',
      title: 'Conseils pour structurer une dissertation',
      description: 'Un modèle simple pour un plan efficace et propre.',
      imageUrl: 'assets/image/sujet4.jpg',
      timeAgo: '2 h',
      aspectRatio: 1,
      level: 'Université',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_FeedItem> get _filteredItems {
    return _feedItems.where((item) {
      final query = _searchController.text.toLowerCase();
      if (query.isNotEmpty) {
        if (!item.title.toLowerCase().contains(query) &&
            !item.description.toLowerCase().contains(query)) {
          return false;
        }
      }
      if (_selectedLevel != null && item.level != _selectedLevel) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AppDrawer(),
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Rechercher un sujet...',
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.divider),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.divider),
                ),
              ),
            ),
          ),

          // Filtres
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _levels.map((level) {
                final isSelected = _selectedLevel == level;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(level),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedLevel = selected ? level : null;
                      });
                    },
                    selectedColor: AppColors.brand,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : AppColors.textSecondary,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? AppColors.brand : AppColors.divider,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Carrousel publicitaire et d'annonces
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PromoCarousel(cards: _buildPromoCards(context)),
          ),

          // Liste des Posts
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: _filteredItems.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) =>
                  _FeedCard(item: _filteredItems[index]),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'ai_assistant_fab',
            onPressed: () {
              context.push('/assistant');
            },
            backgroundColor: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.smart_toy_rounded, color: AppColors.brand),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'post_subject_fab',
            onPressed: () async {
              final result = await context.push<Map<String, dynamic>>(
                '/poster-sujet',
              );
              if (result != null) {
                setState(() {
                  _feedItems.insert(
                    0,
                    _FeedItem(
                      author: result['author'] ?? 'Jean Ouedraogo',
                      username: result['username'] ?? '@jean_ouedraogo',
                      title: result['title'] ?? '',
                      description: result['description'] ?? '',
                      imageUrl: result['imageUrl'] ?? 'assets/image/sujet1.jpg',
                      timeAgo: 'À l\'instant',
                      aspectRatio: 1.0,
                      level: result['level'] ?? 'Lycée',
                    ),
                  );
                });
              }
            },
            backgroundColor: AppColors.brand,
            elevation: 4,
            child: const Icon(Icons.add_circle_outline_rounded, color: Colors.white),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ],
      ),
    );
  }
}

class _FeedCard extends StatelessWidget {
  final _FeedItem item;

  const _FeedCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailScreen(
              author: item.author,
              username: item.username,
              title: item.title,
              description: item.description,
              imageUrl: item.imageUrl,
              timeAgo: item.timeAgo,
              aspectRatio: item.aspectRatio,
              likes: 42,
              shares: 12,
              comments: 8,
              category: item.level,
              publishedAt: DateTime.now().subtract(const Duration(hours: 1)),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.divider),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.brandLight,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.author.split(' ').map((part) => part[0]).join(),
                      style: const TextStyle(
                        color: AppColors.brand,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.author,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.username,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert, size: 20),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.zero,
                bottom: Radius.circular(20),
              ),
              child: AspectRatio(
                aspectRatio: item.aspectRatio,
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: AppColors.background,
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.background,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 32,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _ActionChip(
                            icon: Icons.thumb_up_outlined,
                            label: 'Like',
                          ),
                          const SizedBox(width: 10),
                          _ActionChip(
                            icon: Icons.share_outlined,
                            label: 'Partager',
                            onTap: () {
                              Share.share(
                                '${item.title}\n\n${item.description}\n\nConsultez plus sur Nafa Edu:\n${item.imageUrl}',
                                subject: item.title,
                              );
                            },
                          ),
                        ],
                      ),
                      Text(
                        item.timeAgo,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ActionChip({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.brandLight,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: AppColors.brand),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.brand,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
