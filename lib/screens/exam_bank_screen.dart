import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ExamBankScreen extends StatefulWidget {
  const ExamBankScreen({super.key});

  @override
  State<ExamBankScreen> createState() => _ExamBankScreenState();
}

class _ExamBankScreenState extends State<ExamBankScreen> {
  String _searchQuery = '';
  String _selectedLevel = 'all';
  String _selectedSubject = 'all';
  String _selectedType = 'all';

  final levels = ['all', '3ème', 'Terminale', '1ère', '2nde'];
  final subjects = [
    'all',
    'Mathématiques',
    'Physique-Chimie',
    'SVT',
    'Histoire-Géo',
    'Français',
    'Anglais',
  ];

  final exams = [
    _Exam(
      1,
      'BEPC 2025 - Mathématiques',
      '3ème',
      'Mathématiques',
      'exam',
      15,
      '2h',
      'Moyen',
      1243,
    ),
    _Exam(
      2,
      'BAC Série D 2024 - Physique',
      'Terminale',
      'Physique-Chimie',
      'exam',
      20,
      '3h',
      'Difficile',
      2156,
    ),
    _Exam(
      3,
      'Composition 1er Trimestre - SVT',
      '1ère',
      'SVT',
      'homework',
      12,
      '1h30',
      'Facile',
      876,
    ),
    _Exam(
      4,
      'BEPC 2024 - Histoire-Géo',
      '3ème',
      'Histoire-Géo',
      'exam',
      18,
      '2h',
      'Moyen',
      1567,
    ),
    _Exam(
      5,
      'Concours ENS - Français',
      'Terminale',
      'Français',
      'competition',
      10,
      '4h',
      'Difficile',
      1890,
    ),
    _Exam(
      6,
      'Devoir Surveillé - Anglais',
      '2nde',
      'Anglais',
      'homework',
      25,
      '1h',
      'Facile',
      654,
    ),
    _Exam(
      7,
      'Concours ENAM - Mathématiques',
      'Terminale',
      'Mathématiques',
      'competition',
      30,
      '3h',
      'Difficile',
      987,
    ),
    _Exam(
      8,
      'Devoir Maison - Physique',
      '1ère',
      'Physique-Chimie',
      'homework',
      8,
      '1h',
      'Moyen',
      543,
    ),
  ];

  List<_Exam> get filteredExams {
    return exams.where((exam) {
      final matchesSearch =
          exam.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          exam.subject.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesLevel =
          _selectedLevel == 'all' || exam.level == _selectedLevel;
      final matchesSubject =
          _selectedSubject == 'all' || exam.subject == _selectedSubject;
      final matchesType = _selectedType == 'all' || exam.type == _selectedType;
      return matchesSearch && matchesLevel && matchesSubject && matchesType;
    }).toList();
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Facile':
        return const Color(0xFF059669);
      case 'Moyen':
        return const Color(0xFFD97706);
      case 'Difficile':
        return const Color(0xFFDC2626);
      default:
        return AppColors.textSecondary;
    }
  }

  Color _getDifficultyBg(String difficulty) {
    switch (difficulty) {
      case 'Facile':
        return const Color(0xFFD1FAE5);
      case 'Moyen':
        return const Color(0xFFFEF3C7);
      case 'Difficile':
        return const Color(0xFFFEE2E2);
      default:
        return AppColors.divider;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case 'exam':
        return 'Examen';
      case 'competition':
        return 'Concours';
      case 'homework':
        return 'Devoir';
      default:
        return type;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = filteredExams;

    return Scaffold(
      appBar: AppBar(title: const Text('Banque de Sujets')),
      body: Column(
        children: [
          // Type Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _FilterChip('Tous', 'all'),
                _FilterChip("Sujets d'examen", 'exam'),
                _FilterChip('Concours', 'competition'),
                _FilterChip('Anciens devoirs', 'homework'),
              ],
            ),
          ),

          // Search & Filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Search
                TextField(
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: InputDecoration(
                    hintText: 'Rechercher un sujet...',
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Level & Subject dropdowns
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        value: _selectedLevel,
                        items: levels
                            .map(
                              (l) => DropdownMenuItem(
                                value: l,
                                child: Text(
                                  l == 'all' ? 'Tous niveaux' : l,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _selectedLevel = v!),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildDropdown(
                        value: _selectedSubject,
                        items: subjects
                            .map(
                              (s) => DropdownMenuItem(
                                value: s,
                                child: Text(
                                  s == 'all' ? 'Toutes matières' : s,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _selectedSubject = v!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Count
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${filtered.length} sujet${filtered.length > 1 ? 's' : ''} trouvé${filtered.length > 1 ? 's' : ''}',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Exams List
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.menu_book_rounded,
                          size: 64,
                          color: AppColors.divider,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Aucun sujet trouvé',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final exam = filtered[index];
                      return Container(
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
                            // Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: AppColors.brandLight,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.menu_book_rounded,
                                    color: AppColors.brand,
                                    size: 22,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getDifficultyBg(exam.difficulty),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    exam.difficulty,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _getDifficultyColor(
                                        exam.difficulty,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Title
                            Text(
                              exam.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Tags
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                _tag(
                                  exam.level,
                                  AppColors.divider,
                                  AppColors.textSecondary,
                                ),
                                _tag(
                                  exam.subject,
                                  AppColors.divider,
                                  AppColors.textSecondary,
                                ),
                                _tag(
                                  _getTypeLabel(exam.type),
                                  AppColors.brandLight,
                                  AppColors.brand,
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),

                            // Stats
                            Row(
                              children: [
                                _statBox('${exam.questions}', 'Questions'),
                                const SizedBox(width: 8),
                                _statBox(exam.duration, 'Durée'),
                                const SizedBox(width: 8),
                                _statBox('${exam.downloads}', 'Téléch.'),
                              ],
                            ),
                            const SizedBox(height: 14),

                            // Actions
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () =>
                                        _showExamPreview(context, exam),
                                    icon: Icon(
                                      Icons.visibility_rounded,
                                      size: 18,
                                    ),
                                    label: const Text('Voir'),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                OutlinedButton(
                                  onPressed: () => _downloadExam(context, exam),
                                  child: Icon(Icons.download_rounded, size: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _FilterChip(String label, String type) {
    final isSelected = _selectedType == type;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => setState(() => _selectedType = type),
        selectedColor: AppColors.brand,
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppColors.textSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? AppColors.brand : AppColors.border,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: DropdownButton<String>(
        value: value,
        items: items,
        onChanged: onChanged,
        isExpanded: true,
        underline: const SizedBox(),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.textTertiary,
        ),
      ),
    );
  }

  void _showExamPreview(BuildContext context, _Exam exam) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(exam.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Détails du sujet',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              _detailRow('Niveau', exam.level),
              _detailRow('Matière', exam.subject),
              _detailRow('Type', _getTypeLabel(exam.type)),
              _detailRow('Difficulté', exam.difficulty),
              _detailRow('Questions', '${exam.questions}'),
              _detailRow('Durée', exam.duration),
              _detailRow('Téléchargements', '${exam.downloads}'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aperçu du contenu',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Cet examen contient ${exam.questions} questions couvrant les thèmes principaux de la matière. Durée estimée: ${exam.duration}.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _downloadExam(context, exam);
            },
            child: const Text('Télécharger'),
          ),
        ],
      ),
    );
  }

  void _downloadExam(BuildContext context, _Exam exam) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Téléchargement en cours',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    exam.title,
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.brand,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _tag(String text, Color bg, Color fg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 12, color: fg, fontWeight: FontWeight.w500),
    ),
  );
}

Widget _statBox(String value, String label) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              fontSize: 14,
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
          ),
        ],
      ),
    ),
  );
}

class _Exam {
  final int id;
  final String title, level, subject, type, duration, difficulty;
  final int questions, downloads;
  _Exam(
    this.id,
    this.title,
    this.level,
    this.subject,
    this.type,
    this.questions,
    this.duration,
    this.difficulty,
    this.downloads,
  );
}
