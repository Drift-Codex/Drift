import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  final _nameController = TextEditingController(text: 'Jean Ouedraogo');
  final _emailController = TextEditingController(
    text: 'jean.ouedraogo@example.com',
  );
  final _phoneController = TextEditingController(text: '+226 70 XX XX XX');
  final _schoolController = TextEditingController(
    text: 'Lycée Municipal de Ouagadougou',
  );
  String _level = '3ème';

  final stats = [
    _Stat('Sujets traités', '24', Icons.menu_book_rounded),
    _Stat('Moyenne', '14.5/20', Icons.emoji_events_rounded),
    _Stat('Jours actifs', '45', Icons.calendar_today_rounded),
    _Stat('Progression', '+18%', Icons.trending_up_rounded),
  ];

  final recentSubjects = [
    _Result('Mathématiques', '16/20', '03/05/2026'),
    _Result('Physique-Chimie', '15/20', '02/05/2026'),
    _Result('SVT', '14/20', '01/05/2026'),
    _Result('Histoire-Géo', '13/20', '30/04/2026'),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text('Mon Profil'),
        actions: [
          IconButton(
            onPressed: () => context.go('/'),
            icon: Icon(Icons.logout_rounded, color: AppColors.textSecondary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Avatar
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: AppColors.brand,
                        child: Text(
                          'JO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.brand,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _nameController.text,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$_level - ${_schoolController.text}',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => setState(() => _isEditing = !_isEditing),
                      icon: Icon(
                        _isEditing
                            ? Icons.close_rounded
                            : Icons.settings_rounded,
                        size: 18,
                      ),
                      label: Text(
                        _isEditing ? 'Annuler' : 'Modifier le profil',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Divider(color: AppColors.divider),
                  const SizedBox(height: 16),
                  // Stats
                  ...stats.map(
                    (s) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.brandLight,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  s.icon,
                                  color: AppColors.brand,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                s.label,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            s.value,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Personal info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
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
                    'Informations personnelles',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_isEditing) ...[
                    _buildField(
                      'Nom complet',
                      _nameController,
                      Icons.person_outline_rounded,
                    ),
                    _buildField(
                      'Email',
                      _emailController,
                      Icons.mail_outline_rounded,
                      type: TextInputType.emailAddress,
                    ),
                    _buildField(
                      'Téléphone',
                      _phoneController,
                      Icons.phone_outlined,
                      type: TextInputType.phone,
                    ),
                    _buildField(
                      'Établissement',
                      _schoolController,
                      Icons.school_outlined,
                    ),
                    const SizedBox(height: 8),
                    _label('Niveau'),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: DropdownButton<String>(
                        value: _level,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items:
                            [
                                  '6ème',
                                  '5ème',
                                  '4ème',
                                  '3ème',
                                  '2nde',
                                  '1ère',
                                  'Terminale',
                                ]
                                .map(
                                  (l) => DropdownMenuItem(
                                    value: l,
                                    child: Text(l),
                                  ),
                                )
                                .toList(),
                        onChanged: (v) => setState(() => _level = v!),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => setState(() => _isEditing = false),
                            child: const Text('Enregistrer'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => setState(() => _isEditing = false),
                            child: const Text('Annuler'),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    _infoRow(
                      Icons.mail_outline_rounded,
                      'Email',
                      _emailController.text,
                    ),
                    _infoRow(
                      Icons.phone_outlined,
                      'Téléphone',
                      _phoneController.text,
                    ),
                    _infoRow(
                      Icons.school_outlined,
                      'Établissement',
                      _schoolController.text,
                    ),
                    _infoRow(
                      Icons.calendar_today_rounded,
                      'Date de naissance',
                      '15/05/2010',
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildRoleSection(),
            const SizedBox(height: 20),

            // Recent results
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
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
                    'Résultats récents',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...recentSubjects.map(
                    (r) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.brandLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.menu_book_rounded,
                              color: AppColors.brand,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  r.date,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            r.score,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.brand,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleSection() {
    final user = AuthService.currentUser;
    if (user == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
            'Accès professeur',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text('Rôle actuel : ${user.roleLabel}',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          const SizedBox(height: 14),
          if (user.canRequestTeacherAccess) ...[
            const Text(
              'Vous pouvez demander l’accès professeur. Une fois validé par l’administrateur, vous pourrez activer le mode professeur.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: () {
                final success = AuthService.requestTeacherAccess();
                if (success) {
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Demande d’accès professeur envoyée.'),
                    ),
                  );
                }
              },
              child: const Text('Demander un accès professeur'),
            ),
          ] else if (user.teacherRequestPending) ...[
            Text(
              'Demande en attente.',
              style: TextStyle(fontSize: 14, color: AppColors.brand),
            ),
          ] else if (user.teacherAccessApproved && user.role == UserRole.student) ...[
            const Text(
              'Votre accès professeur est approuvé. Activez le mode professeur pour basculer.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: () {
                AuthService.activateTeacherMode();
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mode professeur activé.'),
                  ),
                );
              },
              child: const Text('Activer le mode professeur'),
            ),
          ] else if (user.role == UserRole.teacher) ...[
            const Text(
              'Vous êtes en mode professeur. Vous pouvez revenir au mode élève ou ouvrir l’espace professeur.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: () {
                AuthService.activateStudentMode();
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mode élève rétabli.'),
                  ),
                );
              },
              child: const Text('Revenir au mode élève'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.go('/teacher-portal'),
              child: const Text('Ouvrir l’espace professeur'),
            ),
          ] else ...[
            Text(
              'Aucun accès professeur demandé ou attribué pour le moment.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController ctrl,
    IconData icon, {
    TextInputType? type,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(label),
          const SizedBox(height: 8),
          TextFormField(
            controller: ctrl,
            keyboardType: type,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: AppColors.textTertiary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String t) => Text(
    t,
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    ),
  );

  Widget _infoRow(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textTertiary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
              ),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat {
  final String label, value;
  final IconData icon;
  _Stat(this.label, this.value, this.icon);
}

class _Result {
  final String name, score, date;
  _Result(this.name, this.score, this.date);
}
