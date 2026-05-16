import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});
  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  String _searchQuery = '';
  String _selectedSubject = 'all';
  final subjects = ['all','Mathématiques','Physique-Chimie','SVT','Histoire-Géo','Français'];
  final posts = [
    _Post(1,'Aminata O.','AO','Comment résoudre ce problème de géométrie ?',
      "Bloquée sur le théorème de Thalès.",'Mathématiques',12,8,'Il y a 2h',['Géométrie'],true),
    _Post(2,'Ibrahim K.','IK','Difficulté avec les équations du second degré',
      "Comment trouver le discriminant ?",'Mathématiques',8,5,'Il y a 4h',['Algèbre'],false),
    _Post(3,'Fatou S.','FS',"Photosynthèse - éclaircissements",
      'Phase claire vs phase sombre ?','SVT',15,12,'Il y a 5h',['Biologie'],true),
    _Post(4,'Moussa T.','MT','Aide dissertation français',
      "Comment structurer une introduction ?",'Français',6,3,'Il y a 1j',['Dissertation'],false),
    _Post(5,'Awa C.','AC','Les lois de Newton',
      "Différence entre les 3 lois ?",'Physique-Chimie',20,15,'Il y a 2j',['Mécanique'],true),
  ];

  List<_Post> get filtered => posts.where((p) {
    final s = p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        p.content.toLowerCase().contains(_searchQuery.toLowerCase());
    final m = _selectedSubject == 'all' || p.subject == _selectedSubject;
    return s && m;
  }).toList();

  @override
  Widget build(BuildContext context) {
    final f = filtered;
    return Scaffold(
      appBar: AppBar(title: const Text("Forum d'Entraide")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {}, icon: Icon(Icons.add_rounded), label: const Text('Question'),
        backgroundColor: AppColors.brand, foregroundColor: Colors.white),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: Column(children: [
          TextField(onChanged: (v) => setState(() => _searchQuery = v),
            decoration: InputDecoration(hintText: 'Rechercher...', prefixIcon: Icon(Icons.search_rounded, color: AppColors.textTertiary))),
          const SizedBox(height: 10),
          SizedBox(height: 40, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: subjects.length,
            itemBuilder: (c, i) {
              final s = subjects[i]; final sel = _selectedSubject == s;
              return Padding(padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(label: Text(s == 'all' ? 'Toutes' : s), selected: sel,
                  onSelected: (_) => setState(() => _selectedSubject = s),
                  selectedColor: AppColors.brand, backgroundColor: Colors.white,
                  labelStyle: TextStyle(color: sel ? Colors.white : AppColors.textSecondary, fontWeight: FontWeight.w500, fontSize: 13),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: sel ? AppColors.brand : AppColors.border)), visualDensity: VisualDensity.compact));
            })),
        ])),
        Expanded(child: f.isEmpty
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.forum_rounded, size: 64, color: AppColors.divider), const SizedBox(height: 12),
              Text('Aucune question', style: TextStyle(color: AppColors.textSecondary))]))
          : ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: f.length,
              itemBuilder: (c, i) => _PostCard(post: f[i]))),
      ]),
    );
  }
}

class _PostCard extends StatelessWidget {
  final _Post post;
  const _PostCard({required this.post});
  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(radius: 20, backgroundColor: AppColors.brand,
            child: Text(post.avatar, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(post.author, style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary, fontSize: 14)),
              const SizedBox(width: 8),
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: AppColors.brandLight, borderRadius: BorderRadius.circular(6)),
                child: Text(post.subject, style: TextStyle(fontSize: 11, color: AppColors.brand, fontWeight: FontWeight.w500))),
            ]),
            Row(children: [Icon(Icons.schedule_rounded, size: 14, color: AppColors.textTertiary), const SizedBox(width: 4),
              Text(post.timeAgo, style: TextStyle(fontSize: 12, color: AppColors.textTertiary))])
          ])),
          if (post.solved) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(6)),
            child: Text('✓ Résolu', style: TextStyle(fontSize: 11, color: const Color(0xFF059669), fontWeight: FontWeight.w600))),
        ]),
        const SizedBox(height: 12),
        Text(post.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 4),
        Text(post.content, style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4), maxLines: 2, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 10),
        Wrap(spacing: 6, children: post.tags.map((t) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(6)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.label_rounded, size: 12, color: AppColors.textTertiary), const SizedBox(width: 4),
            Text(t, style: TextStyle(fontSize: 12, color: AppColors.textSecondary))]))).toList()),
        const SizedBox(height: 12),
        Row(children: [
          Icon(Icons.thumb_up_rounded, size: 16, color: AppColors.textTertiary), const SizedBox(width: 6),
          Text('${post.likes}', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)), const SizedBox(width: 20),
          Icon(Icons.chat_bubble_rounded, size: 16, color: AppColors.textTertiary), const SizedBox(width: 6),
          Text('${post.replies} rép.', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        ]),
      ]));
  }
}

class _Post {
  final int id, likes, replies;
  final String author, avatar, title, content, subject, timeAgo;
  final List<String> tags;
  final bool solved;
  _Post(this.id, this.author, this.avatar, this.title, this.content, this.subject, this.likes, this.replies, this.timeAgo, this.tags, this.solved);
}
