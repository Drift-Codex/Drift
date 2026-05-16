import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      _Service(Icons.menu_book_rounded, 'Banque de Sujets',
          "Accès à des milliers de sujets d'examens avec corrigés détaillés"),
      _Service(Icons.smart_toy_rounded, 'Assistant Intelligent 24/7',
          "Un assistant IA qui guide l'élève dans sa réflexion"),
      _Service(Icons.people_rounded, 'Annuaire de Professeurs',
          "Trouvez des enseignants vérifiés et qualifiés"),
      _Service(Icons.shopping_bag_rounded, 'Marketplace Éducative',
          "Achetez et vendez des contenus pédagogiques"),
      _Service(Icons.forum_rounded, "Forum d'Entraide",
          "Une communauté dynamique d'élèves et d'enseignants"),
      _Service(Icons.track_changes_rounded, 'Publicité Ciblée',
          "Solution marketing pour les établissements scolaires"),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.school_rounded, color: AppColors.brand, size: 28),
                        const SizedBox(width: 8),
                        Text(
                          'Nafa Edu',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => context.go('/auth/login'),
                      child: Text('Connexion',
                          style: TextStyle(color: AppColors.brand, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),

              // Hero Section
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.brandLight, Colors.white],
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  children: [
                    // Offline badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.brandLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.wifi_off_rounded, size: 16, color: AppColors.brand),
                          const SizedBox(width: 6),
                          Text(
                            'Disponible hors ligne',
                            style: TextStyle(
                              color: AppColors.brand,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    Text(
                      "L'infrastructure digitale de l'éducation au Burkina Faso",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      "Une plateforme tout-en-un qui centralise 6 services essentiels pour transformer la réussite scolaire.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // CTA buttons
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => context.go('/auth/signup'),
                        icon: const Icon(Icons.chevron_right_rounded),
                        label: const Text('Découvrir la plateforme'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => context.go('/auth/login'),
                        child: const Text('Se connecter'),
                      ),
                    ),
                  ],
                ),
              ),

              // Services Section
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      '6 Services Intégrés',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tout ce dont vous avez besoin pour réussir',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    ...services.map((service) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(color: AppColors.divider),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: AppColors.brandLight,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(service.icon, color: AppColors.brand, size: 26),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    service.description,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),

              // Benefits Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                color: AppColors.brand,
                child: Column(
                  children: [
                    Text(
                      'Pourquoi Nafa Edu ?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Pensée pour les réalités du Burkina Faso',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 24),

                    _BenefitCard('100%', 'Adapté au programme national burkinabè'),
                    const SizedBox(height: 12),
                    _BenefitCard('24/7', 'Accompagnement disponible à tout moment'),
                    const SizedBox(height: 12),
                    _BenefitCardIcon(Icons.wifi_off_rounded, 'Accès hors ligne aux contenus essentiels'),
                  ],
                ),
              ),

              // CTA Section
              Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.brand, AppColors.brandDark],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Prêt à transformer votre réussite scolaire ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Rejoignez des milliers d'élèves et d'enseignants",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white70),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => context.go('/auth/signup'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.brand,
                          ),
                          child: const Text('Commencer gratuitement'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Footer
              Container(
                width: double.infinity,
                color: const Color(0xFF111827),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.school_rounded, color: Colors.white, size: 22),
                        const SizedBox(width: 8),
                        Text(
                          'Nafa Edu',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "L'infrastructure digitale de l'éducation au Burkina Faso",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white38, fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.white12),
                    const SizedBox(height: 16),
                    Text(
                      '© 2026 Nafa Edu. Tous droits réservés.',
                      style: TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Service {
  final IconData icon;
  final String title;
  final String description;
  _Service(this.icon, this.title, this.description);
}

Widget _BenefitCard(String value, String description) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white)),
        const SizedBox(height: 4),
        Text(description, style: TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    ),
  );
}

Widget _BenefitCardIcon(IconData icon, String description) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 28, color: Colors.white),
        const SizedBox(height: 4),
        Text(description, style: TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    ),
  );
}
