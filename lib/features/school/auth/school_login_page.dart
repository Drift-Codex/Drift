import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/app_feedback.dart';
import '../dashboard/school_dashboard_page.dart';
import 'school_register_page.dart';

class SchoolLoginPage extends StatefulWidget {
  const SchoolLoginPage({super.key});

  @override
  State<SchoolLoginPage> createState() => _SchoolLoginPageState();
}

class _SchoolLoginPageState extends State<SchoolLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginSchool() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SchoolDashboardPage()),
      );
    }
  }

  void _backToTeacherPortal() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
          onPressed: _backToTeacherPortal,
          tooltip: 'Retour au portail professeur',
        ),
        title: const Text(
          'Connexion ecole',
          style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDhNMpDFBoqfUMBJNHfsT7Ctu2dQD7wyqqRCH_qNp3yqad0MyP-VX8HrgPA2znx74EikwoSbPAeRclRW6DZBqo0lEN2YfP5cGLDqX0-mhvaOjMj8leZs1ZIK-rftCl0yNkTnenhA9vHhA3lJJcCII8CrUx3sIXxpBGZTQECBwA-3SxGrEz0Kv8pB9044UXD2tKfQ-4KErAm_ks35rg1ouxFe4Z18n1z9TJBSCx06k5n__0seTtYDltBRNmzDBARRdeSh18k0NBNbQxn',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A111111),
                        blurRadius: 24,
                        offset: Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(Icons.school, color: AppTheme.primary, size: 38),
                        const SizedBox(height: 8),
                        Text(
                          'EduPlatform BF',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Accedez a votre espace professionnel',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(height: 20),
                        Text('Nom d\'utilisateur ou Email', style: Theme.of(context).textTheme.labelSmall),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _usernameController,
                          validator: (value) => value == null || value.isEmpty ? 'Requis' : null,
                          decoration: InputDecoration(
                            hintText: 'votre@email.com',
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('Mot de passe', style: Theme.of(context).textTheme.labelSmall),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) => value == null || value.isEmpty ? 'Requis' : null,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: '••••••••',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => AppFeedback.forgotPasswordDialog(context),
                            child: const Text('Mot de passe oublie ?'),
                          ),
                        ),
                        const SizedBox(height: 6),
                        ElevatedButton.icon(
                          onPressed: _loginSchool,
                          iconAlignment: IconAlignment.end,
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Se connecter'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryContainer,
                            foregroundColor: AppTheme.onPrimaryContainer,
                            minimumSize: const Size.fromHeight(52),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 12),
                        Text(
                          'Nouveau sur la plateforme ?',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SchoolRegisterPage()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppTheme.primary),
                            foregroundColor: AppTheme.primary,
                            minimumSize: const Size.fromHeight(48),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Creer un compte'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified_user, size: 14, color: AppTheme.outline.withValues(alpha: 0.6)),
                  const SizedBox(width: 4),
                  Text(
                    'Connexion Securisee EduPlatform',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.outline),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
