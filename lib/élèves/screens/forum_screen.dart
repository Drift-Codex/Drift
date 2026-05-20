import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';

Widget _buildForumImage(String imagePath, {BoxFit fit = BoxFit.cover}) {
  if (imagePath.startsWith('assets/')) {
    return Image.asset(imagePath, fit: fit);
  }
  return Image.file(File(imagePath), fit: fit);
}

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});
  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedSubject = 'all';
  final subjects = [
    'all',
    'Mathématiques',
    'Physique-Chimie',
    'SVT',
    'Histoire-Géo',
    'Français',
  ];
  final posts = [
    _Post(
      1,
      'Aminata O.',
      'AO',
      'Comment résoudre ce problème de géométrie ?',
      "Bloquée sur le théorème de Thalès.",
      'Mathématiques',
      12,
      8,
      'Il y a 2h',
      ['Géométrie'],
      true,
      [],
      ['assets/image/sujet1.jpg'],
    ),
    _Post(
      2,
      'Ibrahim K.',
      'IK',
      'Difficulté avec les équations du second degré',
      "Comment trouver le discriminant ?",
      'Mathématiques',
      8,
      5,
      'Il y a 4h',
      ['Algèbre'],
      false,
      [],
      ['assets/image/sujet2.jpg'],
    ),
    _Post(
      3,
      'Fatou S.',
      'FS',
      'Photosynthèse - éclaircissements',
      'Phase claire vs phase sombre ?',
      'SVT',
      15,
      12,
      'Il y a 5h',
      ['Biologie'],
      true,
      [],
      ['assets/image/Sujet3.jpg'],
    ),
    _Post(
      4,
      'Moussa T.',
      'MT',
      'Aide dissertation français',
      "Comment structurer une introduction ?",
      'Français',
      6,
      3,
      'Il y a 1j',
      ['Dissertation'],
      false,
      [],
    ),
    _Post(
      5,
      'Awa C.',
      'AC',
      'Les lois de Newton',
      "Différence entre les 3 lois ?",
      'Physique-Chimie',
      20,
      15,
      'Il y a 2j',
      ['Mécanique'],
      true,
      [],
    ),
  ];

  List<_Post> get filtered => posts.where((p) {
    final s =
        p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        p.content.toLowerCase().contains(_searchQuery.toLowerCase());
    final m = _selectedSubject == 'all' || p.subject == _selectedSubject;
    return s && m;
  }).toList();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addComment(_Post post, String text) {
    if (!AuthService.requireLogin(context, action: 'répondre à une question'))
      return;
    if (text.trim().isEmpty) return;

    setState(() {
      post.comments.add(
        _Comment(
          author: AuthService.currentUser?.fullName ?? 'Utilisateur',
          text: text.trim(),
          timeAgo: 'À l’instant',
          likes: 0,
        ),
      );
      post.replies += 1;
    });
  }

  void _likeComment(_Post post, int index) {
    if (!AuthService.requireLogin(context, action: 'aimer une réponse')) return;
    setState(() => post.comments[index].likes += 1);
  }

  void _showCommentSheet(_Post post) {
    final commentController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 60,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.divider,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      post.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${post.comments.length} réponse${post.comments.length > 1 ? 's' : ''}',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 14),
                    if (post.comments.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'Soyez le premier à répondre à cette question.',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      )
                    else
                      Column(
                        children: post.comments
                            .map(
                              (comment) => Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          comment.author,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.thumb_up_rounded,
                                              size: 16,
                                              color: AppColors.textTertiary,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              '${comment.likes}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      comment.text,
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (!AuthService.requireLogin(
                                              context,
                                              action: 'aimer une réponse',
                                            ))
                                              return;
                                            this.setState(() {
                                              comment.likes += 1;
                                            });
                                            setState(() {});
                                          },
                                          icon: Icon(
                                            Icons.thumb_up_alt_outlined,
                                            color: AppColors.brand,
                                          ),
                                        ),
                                        Text(
                                          comment.timeAgo,
                                          style: TextStyle(
                                            color: AppColors.textTertiary,
                                            fontSize: 12,
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
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              hintText: 'Répondre à cette question...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: AppColors.border),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            if (!AuthService.requireLogin(
                              context,
                              action: 'répondre à une question',
                            ))
                              return;
                            final text = commentController.text.trim();
                            if (text.isEmpty) return;
                            this.setState(() {
                              post.comments.add(
                                _Comment(
                                  author:
                                      AuthService.currentUser?.fullName ??
                                      'Utilisateur',
                                  text: text,
                                  timeAgo: 'À l’instant',
                                  likes: 0,
                                ),
                              );
                              post.replies += 1;
                            });
                            setState(() {});
                            commentController.clear();
                          },
                          child: const Text('Envoyer'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final f = filtered;
    return Scaffold(
      endDrawer: const AppDrawer(),
      appBar: AppBar(title: const Text("Forum d'Entraide")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (!AuthService.requireLogin(
            context,
            action: 'poster une question dans le forum',
          ))
            return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForumAskQuestionScreen(
                subjects: subjects,
                onPostCreated: (title, content, subject, images) {
                  setState(() {
                    posts.insert(
                      0,
                      _Post(
                        posts.length + 1,
                        AuthService.currentUser?.fullName ?? 'Utilisateur',
                        AuthService.currentUser?.fullName.characters.first
                                .toUpperCase() ??
                            'U',
                        title,
                        content,
                        subject,
                        0,
                        0,
                        'À l’instant',
                        [subject],
                        false,
                        [],
                        images,
                      ),
                    );
                  });
                },
              ),
            ),
          );
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Question'),
        backgroundColor: AppColors.brand,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (v) {
                    if (!AuthService.isLoggedIn) {
                      AuthService.requireLogin(
                        context,
                        action: 'rechercher dans le forum',
                      );
                      return;
                    }
                    setState(() => _searchQuery = v);
                  },
                  decoration: InputDecoration(
                    hintText: AuthService.isLoggedIn
                        ? 'Rechercher...'
                        : 'Connectez-vous pour rechercher',
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: subjects.length,
                    itemBuilder: (c, i) {
                      final s = subjects[i];
                      final sel = _selectedSubject == s;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(s == 'all' ? 'Toutes' : s),
                          selected: sel,
                          onSelected: (_) =>
                              setState(() => _selectedSubject = s),
                          selectedColor: AppColors.brand,
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: sel ? Colors.white : AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: sel ? AppColors.brand : AppColors.border,
                            ),
                          ),
                          visualDensity: VisualDensity.compact,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: f.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.forum_rounded,
                          size: 64,
                          color: AppColors.divider,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Aucune question',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: f.length,
                    itemBuilder: (c, i) => _PostCard(
                      post: f[i],
                      onLike: () {
                        if (!AuthService.requireLogin(
                          context,
                          action: 'aimer une question',
                        ))
                          return;
                        setState(() => f[i].likes += 1);
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForumPostDetailScreen(
                              post: f[i],
                              onLike: () {
                                if (!AuthService.requireLogin(
                                  context,
                                  action: 'aimer une question',
                                ))
                                  return;
                                setState(() => f[i].likes += 1);
                              },
                              onComment: (text) {
                                _addComment(f[i], text);
                              },
                              onCommentLike: (index) {
                                _likeComment(f[i], index);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final _Post post;
  final VoidCallback onLike;
  final VoidCallback onTap;

  const _PostCard({
    required this.post,
    required this.onLike,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
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
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.brand,
                  child: Text(
                    post.avatar,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.author,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.brandLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              post.subject,
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.brand,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '@${post.author.split(' ').first.toLowerCase()}',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textTertiary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '·',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textTertiary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            post.timeAgo,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (post.solved)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1FAE5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '✓ Résolu',
                      style: TextStyle(
                        fontSize: 11,
                        color: const Color(0xFF059669),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              post.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              post.content,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            if (post.images.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: _buildForumImage(post.images.first, fit: BoxFit.cover),
                ),
              ),
            if (post.images.isNotEmpty) const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              children: post.tags
                  .map(
                    (t) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.label_rounded,
                            size: 12,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            t,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  onPressed: onLike,
                  icon: Icon(
                    Icons.thumb_up_alt_rounded,
                    size: 20,
                    color: AppColors.textTertiary,
                  ),
                ),
                Text(
                  '${post.likes}',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 24),
                IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 20,
                    color: AppColors.textTertiary,
                  ),
                ),
                Text(
                  '${post.replies}',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Comment {
  final String author;
  final String text;
  final String timeAgo;
  int likes;

  _Comment({
    required this.author,
    required this.text,
    required this.timeAgo,
    required this.likes,
  });
}

class _Post {
  final int id;
  final String author;
  final String avatar;
  final String title;
  final String content;
  final String subject;
  int likes;
  int replies;
  final String timeAgo;
  final List<String> tags;
  final bool solved;
  final List<_Comment> comments;
  final List<String> images;

  _Post(
    this.id,
    this.author,
    this.avatar,
    this.title,
    this.content,
    this.subject,
    this.likes,
    this.replies,
    this.timeAgo,
    this.tags,
    this.solved,
    this.comments, [
    this.images = const [],
  ]);
}

class ForumPostDetailScreen extends StatefulWidget {
  final _Post post;
  final ValueChanged<String> onComment;
  final ValueChanged<int> onCommentLike;
  final VoidCallback onLike;

  const ForumPostDetailScreen({
    super.key,
    required this.post,
    required this.onComment,
    required this.onCommentLike,
    required this.onLike,
  });

  @override
  State<ForumPostDetailScreen> createState() => _ForumPostDetailScreenState();
}

class _ForumPostDetailScreenState extends State<ForumPostDetailScreen> {
  final TextEditingController _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Discussion'),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.05),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // The Post Header and Content
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.brand,
                              child: Text(
                                widget.post.avatar,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        widget.post.author,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textPrimary,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.brandLight,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: Text(
                                          widget.post.subject,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: AppColors.brand,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '@${widget.post.author.split(' ').first.toLowerCase()}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textTertiary,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        '·',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textTertiary,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        widget.post.timeAgo,
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
                        const SizedBox(height: 16),
                        Text(
                          widget.post.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.post.content,
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        if (widget.post.images.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: SizedBox(
                              width: double.infinity,
                              height: 260,
                              child: PageView.builder(
                                itemCount: widget.post.images.length,
                                itemBuilder: (context, index) {
                                  final imagePath = widget.post.images[index];
                                  return _buildForumImage(
                                    imagePath,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                          if (widget.post.images.length > 1) ...[
                            const SizedBox(height: 8),
                            Text(
                              '${widget.post.images.length} photo${widget.post.images.length > 1 ? 's' : ''}',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 6,
                          children: widget.post.tags
                              .map(
                                (t) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.label_rounded,
                                        size: 12,
                                        color: AppColors.textTertiary,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        t,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                widget.onLike();
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.thumb_up_alt_rounded,
                                size: 20,
                                color: AppColors.textTertiary,
                              ),
                            ),
                            Text(
                              '${widget.post.likes}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(width: 24),
                            const Icon(
                              Icons.chat_bubble_outline_rounded,
                              size: 20,
                              color: AppColors.textTertiary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.post.replies}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'Commentaires',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),

                  // Comments List
                  if (widget.post.comments.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: Text(
                          'Aucun commentaire pour le moment. Soyez le premier !',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    )
                  else
                    ...widget.post.comments.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final comment = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: AppColors.brandLight,
                              child: Text(
                                comment.author.characters.first.toUpperCase(),
                                style: const TextStyle(
                                  color: AppColors.brand,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: AppColors.divider,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          comment.author,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.textPrimary,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          comment.text,
                                          style: const TextStyle(
                                            color: AppColors.textSecondary,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const SizedBox(width: 12),
                                      Text(
                                        comment.timeAgo,
                                        style: const TextStyle(
                                          color: AppColors.textTertiary,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      GestureDetector(
                                        onTap: () {
                                          widget.onCommentLike(idx);
                                          setState(() {});
                                        },
                                        child: Text(
                                          'J\'aime',
                                          style: TextStyle(
                                            color: comment.likes > 0
                                                ? AppColors.brand
                                                : AppColors.textSecondary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      if (comment.likes > 0) ...[
                                        const SizedBox(width: 6),
                                        const Icon(
                                          Icons.thumb_up_alt_rounded,
                                          size: 12,
                                          color: AppColors.brand,
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          '${comment.likes}',
                                          style: const TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
          ),

          // Bottom Comment Input Field
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ).copyWith(bottom: MediaQuery.of(context).padding.bottom + 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _replyController,
                    decoration: InputDecoration(
                      hintText: 'Écrire un commentaire...',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    final text = _replyController.text.trim();
                    if (text.isEmpty) return;
                    widget.onComment(text);
                    _replyController.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.send_rounded, color: AppColors.brand),
                  padding: const EdgeInsets.all(12),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.brandLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ForumAskQuestionScreen extends StatefulWidget {
  final List<String> subjects;
  final void Function(
    String title,
    String content,
    String subject,
    List<String> images,
  )
  onPostCreated;

  const ForumAskQuestionScreen({
    super.key,
    required this.subjects,
    required this.onPostCreated,
  });

  @override
  State<ForumAskQuestionScreen> createState() => _ForumAskQuestionScreenState();
}

class _ForumAskQuestionScreenState extends State<ForumAskQuestionScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];
  late String _subject;

  @override
  void initState() {
    super.initState();
    _subject = widget.subjects.firstWhere(
      (s) => s != 'all',
      orElse: () => widget.subjects.first,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Poser une question'),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.05),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Titre de la question',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Ex: Comment résoudre cette équation ?',
                filled: true,
                fillColor: Colors.white,
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
            const SizedBox(height: 20),

            const Text(
              'Détails de votre problème',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _contentController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText:
                    'Précisez où vous êtes bloqué, ce que vous ne comprenez pas...',
                filled: true,
                fillColor: Colors.white,
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
            const SizedBox(height: 20),
            const Text(
              'Photos du problème',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 8),
            if (_selectedImages.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedImages.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final image = _selectedImages[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        File(image.path),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () async {
                final images = await _picker.pickMultiImage(imageQuality: 80);
                if (images != null && images.isNotEmpty) {
                  setState(() => _selectedImages.addAll(images));
                }
              },
              icon: const Icon(Icons.photo_camera_outlined),
              label: const Text('Ajouter des photos'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Matière',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _subject,
                  isExpanded: true,
                  items: widget.subjects
                      .where((s) => s != 'all')
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _subject = value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                final content = _contentController.text.trim();
                if (title.isEmpty || content.isEmpty) return;

                widget.onPostCreated(
                  title,
                  content,
                  _subject,
                  _selectedImages.map((image) => image.path).toList(),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brand,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Publier la question',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
