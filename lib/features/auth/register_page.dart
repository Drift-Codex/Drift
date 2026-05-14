import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../main.dart';
import 'auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _schoolController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _subjectController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _acceptTerms = false;
  String? _errorMessage;

  void _register() {
    setState(() {
      _errorMessage = null;
    });

    if (_formKey.currentState!.validate() && _acceptTerms) {
      final username = _usernameController.text.trim();
      final fullName = _fullNameController.text.trim();
      final password = _passwordController.text;

      final success = AuthService.register(
        username: username,
        fullName: fullName,
        password: password,
        subject: _subjectController.text.trim(),
        school: _schoolController.text.trim(),
        email: _emailController.text.trim(),
      );

      if (success) {
        // Enregistrement réussi, on va au dashboard
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainLayout(teacherName: fullName),
          ),
          (route) => false,
        );
      } else {
        // Echec (username déjà pris)
        setState(() {
          _errorMessage = "Ce nom d'utilisateur est déjà pris.";
        });
      }
    } else if (!_acceptTerms) {
      setState(() {
        _errorMessage = "Veuillez accepter les conditions d'utilisation.";
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _schoolController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.school, color: AppTheme.primary),
            const SizedBox(width: 8),
            Text(
              'EduBurkina',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x0D111111),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Hero Image (Nouveau design)
                    Container(
                      height: 240, // Augmenté pour mieux voir l'image
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBR6-3Oc3oh_kkJja12Hcv_e-GZUY2Jq0cQ1dJE1N4cCh32pvc-bJA5bJa3hV2ZgN7o6klAA_QTpNxW3BgLZJouXII-RPDq3Ev6hWTvZz1lfZ7-gbP_L3E19NbzD388oNb-nuIgDqUisof-AFOvbqYdp0uc60ZhYpFJx8Zuik79hch-r36bZQwvoLGnoz1iubQWrvAjD9lona-wa2pkr-WuyNU0zYJ7CVhrb4dvhSVyL8rc_kCzeeqN9YHPfzwfwJfTA1u7_7SLfte2'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Gradient overlay
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppTheme.surface.withValues(alpha: 0.8),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    Text(
                      'Créer un compte',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rejoignez la communauté des enseignants burkinabè pour une excellence pédagogique.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 32),

                    if (_errorMessage != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppTheme.errorContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: AppTheme.onErrorContainer),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    // Nom et Prénom
                    _buildLabel('NOM ET PRÉNOM', context),
                    TextFormField(
                      controller: _fullNameController,
                      decoration: _buildInputDecoration('Ex: Adama Ouédraogo'),
                      validator: (value) => value!.isEmpty ? 'Requis' : null,
                    ),
                    const SizedBox(height: 16),

                    // Username
                    _buildLabel('NOM D\'UTILISATEUR', context),
                    TextFormField(
                      controller: _usernameController,
                      decoration: _buildInputDecoration('Ex: issouf_maths'),
                      validator: (value) => value!.isEmpty ? 'Requis' : null,
                    ),
                    const SizedBox(height: 16),

                    // Matière (saisie libre)
                    _buildLabel('MATIÈRE ENSEIGNÉE', context),
                    TextFormField(
                      controller: _subjectController,
                      textCapitalization: TextCapitalization.words,
                      decoration: _buildInputDecoration('Ex: Mathématiques, Philosophie, Informatique…'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Indiquez votre matière';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Ecole
                    _buildLabel('ÉTABLISSEMENT SCOLAIRE', context),
                    TextFormField(
                      controller: _schoolController,
                      decoration: _buildInputDecoration('Ex: Lycée Philippe Zinda Kaboré'),
                      validator: (value) => value!.isEmpty ? 'Requis' : null,
                    ),
                    const SizedBox(height: 16),

                    // Email
                    _buildLabel('EMAIL PROFESSIONNEL', context),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _buildInputDecoration('nom@exemple.bf'),
                      validator: (value) => value!.isEmpty || !value.contains('@') ? 'Email invalide' : null,
                    ),
                    const SizedBox(height: 16),

                    // Mot de passe
                    _buildLabel('MOT DE PASSE', context),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: _buildInputDecoration('••••••••').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                        ),
                      ),
                      validator: (value) => value!.length < 6 ? 'Min 6 caractères' : null,
                    ),
                    const SizedBox(height: 16),

                    // Terms
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _acceptTerms,
                            activeColor: AppTheme.primaryContainer,
                            onChanged: (value) {
                              setState(() {
                                _acceptTerms = value ?? false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.onSurfaceVariant),
                              children: const [
                                TextSpan(text: 'J\'accepte les '),
                                TextSpan(
                                  text: 'conditions d\'utilisation',
                                  style: TextStyle(color: AppTheme.primaryContainer, decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: ' et la politique de confidentialité.'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryContainer,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      child: const Text('S\'inscrire', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    const SizedBox(height: 24),
                    
                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Déjà inscrit ? ', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Se connecter', style: TextStyle(color: AppTheme.primaryContainer, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppTheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppTheme.primaryContainer, width: 2),
      ),
    );
  }
}
