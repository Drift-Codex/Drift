import 'package:flutter/material.dart';

// Cohérence avec ta charte graphique
class AppColors {
  static const Color brand = Color(0xFF5863F8);          // Violet-bleu principal
  static const Color background = Color(0xFFF5F7FA);    // Fond clair
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1E1E2C);   // Texte foncé
  static const Color textSecondary = Color(0xFF6B7280); // Texte secondaire
  static const Color textTertiary = Color(0xFF9CA3AF);  // Texte tertiaire
  static const Color divider = Color(0xFFE5E7EB);       // Séparateurs

  static Color easyColor = const Color(0xFF10B981);    // Vert menthe
  static Color mediumColor = const Color(0xFFF59E0B);  // Ambre
  static Color hardColor = const Color(0xFFEF4444);    // Rouge doux
}

class QuizConfigurationScreen extends StatefulWidget {
  const QuizConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<QuizConfigurationScreen> createState() => _QuizConfigurationScreenState();
}

class _QuizConfigurationScreenState extends State<QuizConfigurationScreen> {
  // Variables d'état pour stocker les choix de l'utilisateur
  String? _selectedCycle;
  String? _selectedClass;
  String? _selectedSubject;
  String _selectedDifficulty = 'Moyen';
  double _questionCount = 10;

  // Données de test (À remplacer plus tard par tes données réelles ou ton API)
  final List<String> _cycles = ['Primaire', 'Collège', 'Lycée', 'Université'];
  final List<String> _classes = ['Seconde', 'Première', 'Terminale'];
  final List<String> _subjects = ['Mathématiques', 'Physique-Chimie', 'Histoire-Géo', 'SVT', 'Informatique'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Configuration',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- TITRE EXPLICATIF ---
                    const Text(
                      'Personnalise ton test ⚙️',
                      style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Cible ton niveau pour obtenir un quiz sur-mesure.',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 24),

                    // --- DROPDOWN : CYCLE ---
                    _buildSectionTitle('1. Choisis le cycle scolaire'),
                    _buildDropdown(
                      hint: 'Sélectionner un cycle',
                      icon: Icons.layers_rounded,
                      value: _selectedCycle,
                      items: _cycles,
                      onChanged: (val) => setState(() => _selectedCycle = val),
                    ),
                    const SizedBox(height: 20),

                    // --- DROPDOWN : CLASSE ---
                    _buildSectionTitle('2. Choisis la classe'),
                    _buildDropdown(
                      hint: 'Sélectionner la classe',
                      icon: Icons.school_rounded,
                      value: _selectedClass,
                      items: _classes,
                      onChanged: (val) => setState(() => _selectedClass = val),
                    ),
                    const SizedBox(height: 20),

                    // --- DROPDOWN : MATIÈRE ---
                    _buildSectionTitle('3. Sélectionne la matière'),
                    _buildDropdown(
                      hint: 'Sélectionner la matière',
                      icon: Icons.book_rounded,
                      value: _selectedSubject,
                      items: _subjects,
                      onChanged: (val) => setState(() => _selectedSubject = val),
                    ),
                    const SizedBox(height: 24),

                    // --- SELECTION DIFFICULTÉ (CHIPS) ---
                    _buildSectionTitle('4. Niveau de difficulté'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildDifficultyChip('Facile', AppColors.easyColor),
                        const SizedBox(width: 10),
                        _buildDifficultyChip('Moyen', AppColors.mediumColor),
                        const SizedBox(width: 10),
                        _buildDifficultyChip('Difficile', AppColors.hardColor),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // --- SLIDER : NOMBRE DE QUESTIONS ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSectionTitle('5. Nombre de questions'),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.brand.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${_questionCount.toInt()} Qs',
                            style: const TextStyle(color: AppColors.brand, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _questionCount,
                      min: 5,
                      max: 20,
                      divisions: 3, // Permet des paliers nets : 5, 10, 15, 20
                      activeColor: AppColors.brand,
                      inactiveColor: AppColors.divider,
                      onChanged: (val) => setState(() => _questionCount = val),
                    ),
                  ],
                ),
              ),
            ),

            // --- BOUTON DE SOUUMISSION FIXE EN BAS ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: (_selectedCycle != null && _selectedClass != null && _selectedSubject != null)
                      ? _startQuiz
                      : null, // Reste grisé tant que l'entonnoir n'est pas complet
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brand,
                    disabledBackgroundColor: AppColors.textTertiary.withOpacity(0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Lancer le Quiz ⚡',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper pour les titres de section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Composant Dropdown stylisé de niveau pro
  Widget _buildDropdown({
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint, style: const TextStyle(color: AppColors.textTertiary, fontSize: 14)),
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.brand, size: 22),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.brand, width: 1.5),
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: const TextStyle(color: AppColors.textPrimary, fontSize: 15)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  // Composant de puces (Chips) pour le choix de la difficulté
  Widget _buildDifficultyChip(String label, Color color) {
    final bool isSelected = _selectedDifficulty == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedDifficulty = label),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: isSelected ? color : AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? color : AppColors.divider,
              width: 1,
            ),
            boxShadow: isSelected
                ? [BoxShadow(color: color.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 3))]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  // Logique de déclenchement du quiz
  void _startQuiz() {
    // Action de redirection vers l'écran de jeu de quiz actif
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('⚡ Génération d\'un quiz de ${_questionCount.toInt()} questions en $_selectedSubject...'),
        backgroundColor: AppColors.brand,
      ),
    );
  }
}