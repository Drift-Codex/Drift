import 'package:flutter/material.dart';

// Reprise de ta classe de couleurs pour la cohérence visuelle
class AppColors {
  static const Color brand = Color(0xFF5863F8);          // Violet-bleu principal
  static const Color background = Color(0xFFF5F7FA);    // Fond clair
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1E1E2C);   // Texte foncé
  static const Color textSecondary = Color(0xFF6B7280); // Texte secondaire
  static const Color textTertiary = Color(0xFF9CA3AF);  // Texte tertiaire
  static const Color divider = Color(0xFFE5E7EB);       // Séparateurs
  static const Color brandLight = Color(0x0F5863F8);    // Fond léger (opacité 6%)
}

class AiQuizUploadScreen extends StatefulWidget {
  const AiQuizUploadScreen({Key? key}) : super(key: key);

  @override
  State<AiQuizUploadScreen> createState() => _AiQuizUploadScreenState();
}

class _AiQuizUploadScreenState extends State<AiQuizUploadScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isUploading = false;
  String? _selectedFileName; // Simule le nom du fichier choisi

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

  // Simulation du choix de fichier
  void _pickFile() {
    setState(() {
      _selectedFileName = "Mon_Cours_de_Reseaux_LAN.pdf";
    });
  }

  // Simulation de la génération IA
  void _generateQuiz() async {
    if (_selectedFileName == null) return;

    setState(() {
      _isUploading = true;
    });

    // On simule une attente de 4 secondes pour l'analyse IA
    await Future.delayed(const Duration(seconds: 4));

    setState(() {
      _isUploading = false;
    });

    // TODO: Rediriger l'utilisateur vers l'écran du Quiz généré
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✨ Quiz généré avec succès par l\'IA !'),
        backgroundColor: Colors.green,
      ),
    );
  }

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
          'Créer via l\'IA',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER CONTEXTUEL ---
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.brand.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.auto_awesome_rounded, color: AppColors.brand, size: 24),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Générateur de Quiz Intelligent',
                          style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Uploadez votre support pour extraire les questions.',
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // --- SÉLECTEUR DE MÉTHODE (ONGLETS) ---
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.divider.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.textPrimary.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  labelColor: AppColors.brand,
                  unselectedLabelColor: AppColors.textSecondary,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  tabs: const [
                    Tab(text: 'Document (PDF, Word)'),
                    Tab(text: 'Scanner / Photo'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // --- CONTENU DES ONGLETS ---
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(), // Évite les conflits de swipe
                  children: [
                    _buildUploadZone(
                      context,
                      title: 'Sélectionner un fichier de cours',
                      subtitle: 'PDF, DOCX jusqu\'à 10 Mo',
                      icon: Icons.cloud_upload_outlined,
                      onTap: _pickFile,
                    ),
                    _buildUploadZone(
                      context,
                      title: 'Prendre une photo du document',
                      subtitle: 'Capturez une page claire de votre cahier',
                      icon: Icons.camera_alt_outlined,
                      onTap: _pickFile, // Réutilisé pour la démo
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // --- INFO COMPLÉMENTAIRE ---
              if (!_isUploading)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.brandLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.lock_outline, color: AppColors.brand, size: 20),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Vos documents restent strictement confidentiels et ne sont utilisés que pour générer votre session.',
                          style: TextStyle(color: AppColors.brand, fontSize: 12, height: 1.3),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),

              // --- BOUTON DE SOUUMISSION / CHARGEMENT DYNAMIQUE ---
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: (_selectedFileName != null && !_isUploading) ? _generateQuiz : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brand,
                    disabledBackgroundColor: AppColors.textTertiary.withOpacity(0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: _isUploading
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                            ),
                            SizedBox(width: 14),
                            Text(
                              'L\'IA analyse votre cours...',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      : const Text(
                          'Générer mon Quiz IA ✨',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Composant visuel de la boîte de dépôt (Dashed Container effect)
  Widget _buildUploadZone(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: _isUploading ? null : onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _selectedFileName != null ? AppColors.brand : AppColors.textTertiary.withOpacity(0.4),
            width: 1.5,
            style: BorderStyle.solid, // Flutter gère nativement le BorderStyle.solid.
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animation ou changement d'icône si un fichier est choisi
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _selectedFileName != null ? AppColors.brand.withOpacity(0.1) : AppColors.background,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _selectedFileName != null ? Icons.task_alt_rounded : icon,
                size: 40,
                color: _selectedFileName != null ? AppColors.brand : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _selectedFileName ?? title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: _selectedFileName != null ? FontWeight.bold : FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _selectedFileName != null ? "Fichier prêt pour l'analyse" : subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            if (_selectedFileName != null && !_isUploading) ...[
              const SizedBox(height: 24),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _selectedFileName = null;
                  });
                },
                icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 18),
                label: const Text('Retirer le fichier', style: TextStyle(color: Colors.redAccent)),
              )
            ]
          ],
        ),
      ),
    );
  }
}