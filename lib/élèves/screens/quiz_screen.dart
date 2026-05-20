import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppColors {
  static const Color brand = Color(0xFF5863F8);          // Violet-bleu principal
  static const Color background = Color(0xFFF5F7FA);    // Fond clair
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1E1E2C);   // Texte foncé
  static const Color textSecondary = Color(0xFF6B7280); // Texte secondaire
  static const Color textTertiary = Color(0xFF9CA3AF);  // Texte tertiaire
  static const Color divider = Color(0xFFE5E7EB);       // Séparateurs
  static const Color brandLight = Color(0x0F5863F8);    // Fond léger pour badges

  static Color easyColor = const Color(0xFF10B981);    // Vert menthe
  static Color mediumColor = const Color(0xFFF59E0B);  // Ambre
  static Color hardColor = const Color(0xFFEF4444);    // Rouge doux
}

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: const Text(
          'Quiz d\'évaluation',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SECTION HEADER ---
              const Text(
                'Prêt pour un défi ? 🏆',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Choisis ta méthode d\'entraînement',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 24),

              // --- SECTION HISTORIQUE (REMENTÉE) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mes derniers scores',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Voir tout',
                      style: TextStyle(color: AppColors.brand, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildHistorySection(),
              const SizedBox(height: 28),

              // --- SECTION SÉLECTION DES MODES ---
              const Text(
                'Modes disponibles',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              _buildQuizOption(
  context,
  title: 'Quiz Automatique',
  description:
      'Générez un test basé officiellement sur votre programme scolaire.',
  icon: Icons.school_rounded,
  isAI: false,
  onTap: () {
    context.push('/quiz-configuration');
  },
),

const SizedBox(height: 16),

_buildQuizOption(
  context,
  title: 'Quiz IA Personnalisé',
  description:
      'Uploadez votre propre cours (PDF ou photo) et l\'IA génère un quiz sur mesure.',
  icon: Icons.auto_awesome_rounded,
  isAI: true,
  onTap: () {
    context.push('/ai-quiz-upload');
  },
),
            ],
          ),
        ),  
      
      ),
    );
  }

  // Widget de construction des options de Quiz (Design Premium)
  Widget _buildQuizOption(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required bool isAI,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          // Un léger dégradé à l'arrière pour l'option IA pour la rendre attractive
          gradient: isAI
              ? LinearGradient(
                  colors: [AppColors.surface, AppColors.brand.withOpacity(0.04)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withOpacity(0.04),
              spreadRadius: 2,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: isAI ? Border.all(color: AppColors.brand.withOpacity(0.2), width: 1) : null,
        ),
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isAI ? AppColors.brand.withOpacity(0.1) : AppColors.brandLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 28,
                color: AppColors.brand,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isAI) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.brand,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'PRO',
                            style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                          ),
                        )
                      ]
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textTertiary, size: 16),
          ],
        ),
      ),
    );
  }

  // Section historique horizontale moderne
  Widget _buildHistorySection() {
    final history = [
      {'title': 'Quiz Automatique', 'type': 'Maths', 'score': '8/10', 'isSuccess': true},
      {'title': 'Quiz IA Document', 'type': 'Réseaux', 'score': '7/10', 'isSuccess': true},
    ];

    return SizedBox(
      height: 72,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final entry = history[index];
          return Container(
            width: 220,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider, width: 1),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.easyColor.withOpacity(0.1),
                  child: Icon(Icons.check_rounded, color: AppColors.easyColor, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry['title'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        entry['type'] as String,
                        style: const TextStyle(color: AppColors.textTertiary, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Text(
                  entry['score'] as String,
                  style: const TextStyle(color: AppColors.brand, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}