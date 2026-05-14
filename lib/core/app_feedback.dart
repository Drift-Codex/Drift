import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

/// Snackbars et dialogues simples pour que chaque action ait un retour visible.
class AppFeedback {
  AppFeedback._();

  static void snackBar(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static Future<void> forgotPasswordDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Mot de passe oublié'),
        content: const Text(
          'Un lien de réinitialisation sera envoyé à votre adresse e-mail enregistrée. '
          'Fonctionnalité de démonstration : contactez le support pour un compte réel.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Fermer'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              snackBar(context, 'Demande enregistrée (démo).');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static Future<void> helpDialog(BuildContext context, {String? title}) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title ?? 'Aide'),
        content: const Text(
          'Support EduPlatform BF (démo)\n\n'
          'E-mail : support@eduplatform.bf\n'
          'WhatsApp : +226 XX XX XX XX',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  static Future<void> confirm(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmLabel = 'Confirmer',
  }) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Annuler')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppTheme.primaryContainer),
            onPressed: () {
              Navigator.pop(ctx);
              onConfirm();
            },
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
  }
}
