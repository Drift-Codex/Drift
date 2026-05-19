import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/user.dart';

class AuthService {
  static final Map<String, AppUser> _users = {};
  static final Map<String, String> _passwords = {};

  static AppUser? currentUser;

  static bool get isLoggedIn => currentUser != null;

  static bool requireLogin(BuildContext context, {String action = 'utiliser cette fonctionnalité'}) {
    if (isLoggedIn) return true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Connexion requise'),
        content: Text(
          'Vous devez créer un compte ou vous connecter pour $action.',
          style: const TextStyle(height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Plus tard'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              GoRouter.of(context).go('/auth/login');
            },
            child: const Text('Se connecter'),
          ),
        ],
      ),
    );

    return false;
  }

  static String? register({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    String school = '',
  }) {
    final normalizedEmail = email.trim().toLowerCase();
    if (_users.containsKey(normalizedEmail)) {
      return 'Un compte existe déjà avec cette adresse email.';
    }

    final user = AppUser(
      fullName: fullName.trim(),
      email: normalizedEmail,
      phone: phone.trim(),
      school: school.trim(),
    );

    _users[normalizedEmail] = user;
    _passwords[normalizedEmail] = password;
    currentUser = user;
    return null;
  }

  static String? login(String email, String password) {
    final normalizedEmail = email.trim().toLowerCase();
    if (!_users.containsKey(normalizedEmail)) {
      return 'Aucun compte trouvé pour cet email.';
    }

    if (_passwords[normalizedEmail] != password) {
      return 'Mot de passe incorrect.';
    }

    currentUser = _users[normalizedEmail];
    return null;
  }

  static void logout() {
    currentUser = null;
  }

  static bool requestTeacherAccess() {
    final user = currentUser;
    if (user == null || !user.canRequestTeacherAccess) {
      return false;
    }

    final updated = user.copyWith(teacherRequestPending: true);
    _users[user.email] = updated;
    currentUser = updated;
    return true;
  }

  static bool approveTeacherAccess(String email) {
    final normalizedEmail = email.trim().toLowerCase();
    final user = _users[normalizedEmail];
    if (user == null) {
      return false;
    }

    final updated = user.copyWith(
      teacherRequestPending: false,
      teacherAccessApproved: true,
    );
    _users[normalizedEmail] = updated;
    if (currentUser?.email == normalizedEmail) {
      currentUser = updated;
    }
    return true;
  }

  static bool activateTeacherMode() {
    final user = currentUser;
    if (user == null || !user.teacherAccessApproved) {
      return false;
    }

    final updated = user.copyWith(role: UserRole.teacher);
    _users[user.email] = updated;
    currentUser = updated;
    return true;
  }

  static bool activateStudentMode() {
    final user = currentUser;
    if (user == null) {
      return false;
    }

    final updated = user.copyWith(role: UserRole.student);
    _users[user.email] = updated;
    currentUser = updated;
    return true;
  }
}
