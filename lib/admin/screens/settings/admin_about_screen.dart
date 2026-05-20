import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/admin_colors.dart';

class AdminAboutScreen extends StatelessWidget {
  const AdminAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.background,
      appBar: AppBar(
        backgroundColor: AdminColors.background,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AdminColors.textPrimary), onPressed: () => context.pop()),
        title: const Text('À propos de l\'application', style: TextStyle(color: AdminColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: AdminColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.school, size: 64, color: AdminColors.primary),
              ),
              const SizedBox(height: 24),
              const Text('Nafa Edu Admin', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AdminColors.textPrimary)),
              const SizedBox(height: 8),
              const Text('Version 1.0.0', style: TextStyle(color: AdminColors.textSecondary)),
              const SizedBox(height: 32),
              const Text('Plateforme éducative de partage de sujets et cours. Créé avec passion pour l\'éducation.', textAlign: TextAlign.center, style: TextStyle(color: AdminColors.textSecondary, height: 1.5)),
              const SizedBox(height: 48),
              TextButton(onPressed: () {}, child: const Text('Conditions d\'utilisation', style: TextStyle(color: AdminColors.primary))),
              TextButton(onPressed: () {}, child: const Text('Politique de confidentialité', style: TextStyle(color: AdminColors.primary))),
            ],
          ),
        ),
      ),
    );
  }
}
