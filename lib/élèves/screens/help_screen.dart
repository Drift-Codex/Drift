import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        'question': 'Comment suivre ma progression ?',
        'answer':
            'La page d’accueil affiche vos statistiques et votre activité récente.',
      },
      {
        'question': 'Comment poser une question au forum ?',
        'answer':
            'Accédez à l’écran Forum et publiez votre sujet avec une description claire.',
      },
      {
        'question': 'Comment modifier mes informations ?',
        'answer':
            'Allez dans Mon Profil ou Paramètres pour mettre à jour vos données.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              context.go('/dashboard');
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Aide'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Questions fréquentes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 18),
            ...faqs.map(
              (faq) => Container(
                margin: const EdgeInsets.only(bottom: 14),
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
                    Text(
                      faq['question']!,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      faq['answer']!,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
