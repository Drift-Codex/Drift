import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/app_feedback.dart';
import 'school_login_page.dart';

class SchoolRegisterPage extends StatefulWidget {
  const SchoolRegisterPage({super.key});

  @override
  State<SchoolRegisterPage> createState() => _SchoolRegisterPageState();
}

class _SchoolRegisterPageState extends State<SchoolRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _schoolNameController = TextEditingController();
  final _approvalController = TextEditingController();
  final _cityController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _acceptTerms = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _schoolNameController.dispose();
    _approvalController.dispose();
    _cityController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _acceptTerms) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SchoolLoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        title: Row(
          children: [
            const Icon(Icons.school, color: AppTheme.primary),
            const SizedBox(width: 8),
            Text('EduPlatform BF', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppTheme.primary)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            child: const Text('Portail professeur'),
          ),
          TextButton(
            onPressed: () => AppFeedback.helpDialog(context, title: 'Aide — inscription école'),
            child: const Text('Aide'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAO-ZrJ6U7NNw2jHPk4M5FtqvvJZahfoAVRdze74pZNNZndc0BAdyNv1fAqVTd0oCri9RrszcT-fMgMz9zmE17yc56zDihkhSMhNVE3KZ3sf6mjHqUlSnsjpdjFS5ccLJZ1F0VD5WTX3_wYYKmto2_7Spwr_a2iM8t9tb6cuasq6EM8P2d2soiLuX33TOubVI7c_gcAGdel2HioGGmmjrWL7Wxj-KwTLpXWfJmk3jj1z-dKA1nGk00nejeazK78N8tyGozyXExtlNFy',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(16),
              child: Container(
                color: Colors.black.withValues(alpha: 0.35),
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'Inscrivez votre etablissement sur la plateforme d\'excellence du Burkina Faso.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(color: Color(0x0D111111), blurRadius: 12, offset: Offset(0, 4))],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(height: 4, width: 48, decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(99))),
                        const SizedBox(width: 8),
                        Text('ETAPE UNIQUE DE CREATION', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.primary)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _field('Nom de l\'ecole', _schoolNameController, 'Ex: Lycee Technique de Ouagadougou'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _field('Numero d\'agrement', _approvalController, 'N° 2024-001')),
                        const SizedBox(width: 12),
                        Expanded(child: _field('Ville', _cityController, 'Ouagadougou')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    _field('Email administrateur', _emailController, 'admin@ecole.bf', keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 12),
                    _field('Nom d\'utilisateur', _usernameController, 'ecole_admin_01'),
                    const SizedBox(height: 12),
                    Text('Mot de passe', style: Theme.of(context).textTheme.labelSmall),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      validator: (value) => value == null || value.isEmpty ? 'Requis' : null,
                      decoration: InputDecoration(
                        hintText: '••••••••',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                          icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: _acceptTerms,
                      onChanged: (value) => setState(() => _acceptTerms = value ?? false),
                      title: const Text(
                        'J\'accepte les conditions generales d\'utilisation et la politique de confidentialite.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _submit,
                      iconAlignment: IconAlignment.end,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Creer le compte ecole'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryContainer,
                        foregroundColor: AppTheme.onPrimaryContainer,
                        minimumSize: const Size.fromHeight(54),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Votre etablissement est deja inscrit ? ', style: Theme.of(context).textTheme.bodySmall),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const SchoolLoginPage()),
                            );
                          },
                          child: const Text('Se connecter', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                        ),
                      ],
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

  Widget _field(
    String label,
    TextEditingController controller,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: (value) => value == null || value.isEmpty ? 'Requis' : null,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
