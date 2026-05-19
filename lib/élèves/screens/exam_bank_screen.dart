import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../theme/app_theme.dart';
import 'post_detail_screen.dart';
import '../widgets/app_drawer.dart';

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

  static const List<_FeedItem> allItems = [
    _FeedItem(
      author: 'Aminata O.',
      username: '@aminata',
      title: 'Astuce rapide : réussir les transformations algébriques',
      description: 'Un guide visuel et simple pour transformer les équations sans stress.',
      imageUrl: 'assets/image/sujet1.jpg',
      timeAgo: '12 min',
      aspectRatio: 4 / 5,
      level: 'Lycée',
    ),
    _FeedItem(
      author: 'Ibrahim K.',
      username: '@ibrahim',
      title: 'Révision express : les lois de Newton',
      description: 'Des exemples faciles à relire avant l’examen du prochain jour.',
      imageUrl: 'assets/image/sujet2.jpg',
      timeAgo: '45 min',
      aspectRatio: 1,
      level: 'Lycée',
    ),
    _FeedItem(
      author: 'Fatou S.',
      username: '@fatou',
      title: 'Fiches de synthèse : Photosynthèse et respiration',
      description: 'Un support visuel clair pour retenir les étapes principales.',
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
    return allItems.where((item) {
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
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: isSelected ? AppColors.brand : AppColors.divider),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Liste des Posts
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: _filteredItems.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) => _FeedCard(item: _filteredItems[index]),
            ),
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
