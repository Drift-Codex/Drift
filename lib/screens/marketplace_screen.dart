import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});
  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'all';
  String _selectedType = 'all';
  final categories = ['all','Mathématiques','Physique-Chimie','SVT','Histoire-Géo','Français'];
  final types = [
    _Type('all','Tous', Icons.filter_list_rounded),
    _Type('course','Cours', Icons.menu_book_rounded),
    _Type('video','Vidéos', Icons.videocam_rounded),
    _Type('document','Documents', Icons.description_rounded),
    _Type('audio','Audio', Icons.headphones_rounded),
  ];
  final products = [
    _Product(1,'Pack Complet Maths BEPC','Prof. Ouedraogo','Mathématiques','course',5000,4.8,127,450),
    _Product(2,'Vidéos Physique Terminale D','Prof. Sankara','Physique-Chimie','video',7500,4.9,89,320),
    _Product(3,'Fiches de Révision SVT','Prof. Compaoré','SVT','document',2500,4.6,203,680),
    _Product(4,'Cours Audio Histoire-Géo','Prof. Kaboré','Histoire-Géo','audio',4000,4.7,156,290),
    _Product(5,'Méthodologie Dissertation','Prof. Traoré','Français','course',6000,4.9,241,540),
    _Product(6,'Exercices Corrigés Maths','Prof. Sawadogo','Mathématiques','document',3500,4.8,178,620),
  ];

  List<_Product> get filtered => products.where((p) {
    final s = p.title.toLowerCase().contains(_searchQuery.toLowerCase()) || p.author.toLowerCase().contains(_searchQuery.toLowerCase());
    final c = _selectedCategory == 'all' || p.category == _selectedCategory;
    final t = _selectedType == 'all' || p.type == _selectedType;
    return s && c && t;
  }).toList();

  IconData _typeIcon(String type) => types.firstWhere((t) => t.value == type, orElse: () => types[0]).icon;

  @override
  Widget build(BuildContext context) {
    final f = filtered;
    return Scaffold(
      appBar: AppBar(title: const Text('Marketplace'),
        actions: [
          Stack(children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart_rounded)),
            Positioned(right: 6, top: 6, child: Container(width: 16, height: 16,
              decoration: BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
              child: Center(child: Text('0', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)))))
          ]),
        ]),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: Column(children: [
          TextField(onChanged: (v) => setState(() => _searchQuery = v),
            decoration: InputDecoration(hintText: 'Rechercher un contenu...', prefixIcon: Icon(Icons.search_rounded, color: AppColors.textTertiary))),
          const SizedBox(height: 10),
          // Type chips
          SizedBox(height: 40, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: types.length,
            itemBuilder: (c, i) {
              final t = types[i]; final sel = _selectedType == t.value;
              return Padding(padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(label: Text(t.label), selected: sel, avatar: Icon(t.icon, size: 16, color: sel ? Colors.white : AppColors.textSecondary),
                  onSelected: (_) => setState(() => _selectedType = t.value),
                  selectedColor: AppColors.brand, backgroundColor: Colors.white,
                  labelStyle: TextStyle(color: sel ? Colors.white : AppColors.textSecondary, fontWeight: FontWeight.w500, fontSize: 13),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: sel ? AppColors.brand : AppColors.border)),
                  visualDensity: VisualDensity.compact));
            })),
          const SizedBox(height: 10),
          // Category dropdown
          Container(padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: DropdownButton<String>(value: _selectedCategory, isExpanded: true, underline: const SizedBox(),
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textTertiary),
              items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c == 'all' ? 'Toutes les matières' : c, style: TextStyle(fontSize: 14)))).toList(),
              onChanged: (v) => setState(() => _selectedCategory = v!))),
          const SizedBox(height: 8),
          Align(alignment: Alignment.centerLeft, child: Text('${f.length} produit${f.length > 1 ? 's' : ''}',
            style: TextStyle(fontSize: 13, color: AppColors.textTertiary))),
        ])),
        Expanded(child: f.isEmpty
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.shopping_cart_rounded, size: 64, color: AppColors.divider), const SizedBox(height: 12),
              Text('Aucun produit', style: TextStyle(color: AppColors.textSecondary))]))
          : ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: f.length,
              itemBuilder: (c, i) => _ProductCard(product: f[i], typeIcon: _typeIcon(f[i].type)))),
      ]),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final _Product product;
  final IconData typeIcon;
  const _ProductCard({required this.product, required this.typeIcon});
  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))]),
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        // Image placeholder
        Container(height: 140, width: double.infinity,
          decoration: BoxDecoration(gradient: LinearGradient(colors: [AppColors.brand, AppColors.brandDark], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Center(child: Icon(typeIcon, size: 56, color: Colors.white.withOpacity(0.4)))),
        // Content
        Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: AppColors.brandLight, borderRadius: BorderRadius.circular(6)),
              child: Text(product.category, style: TextStyle(fontSize: 11, color: AppColors.brand, fontWeight: FontWeight.w500))),
            Row(children: [
              Icon(Icons.star_rounded, size: 16, color: const Color(0xFFFBBF24)),
              const SizedBox(width: 4),
              Text('${product.rating}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              Text(' (${product.reviews})', style: TextStyle(fontSize: 11, color: AppColors.textTertiary)),
            ]),
          ]),
          const SizedBox(height: 10),
          Text(product.title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(product.author, style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: 10),
          Row(children: [
            Icon(typeIcon, size: 16, color: AppColors.textTertiary), const SizedBox(width: 4),
            Text('${product.students} élèves', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ]),
          const SizedBox(height: 14),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
              Text('${product.price}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.brand)),
              const SizedBox(width: 4),
              Text('FCFA', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ]),
            ElevatedButton(onPressed: () {}, child: const Text('Acheter')),
          ]),
        ])),
      ]));
  }
}

class _Type { final String value, label; final IconData icon; _Type(this.value, this.label, this.icon); }
class _Product {
  final int id, reviews, students; final double rating; final int price;
  final String title, author, category, type;
  _Product(this.id, this.title, this.author, this.category, this.type, this.price, this.rating, this.reviews, this.students);
}
