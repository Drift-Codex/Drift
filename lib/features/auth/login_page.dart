import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/app_feedback.dart';
import '../../main.dart';
import 'register_page.dart';
import 'auth_service.dart';
import '../school/auth/school_login_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String? _errorMessage;

  void _login() {
    setState(() {
      _errorMessage = null;
    });

    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text.trim();
      final password = _passwordController.text;

      final fullName = AuthService.login(username, password);

      if (fullName != null) {
        // Succès de la connexion, on passe au dashboard avec le nom
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainLayout(teacherName: fullName),
          ),
        );
      } else {
        // Echec (soit non inscrit, soit mauvais mdp)
        if (!AuthService.isRegistered(username)) {
          setState(() {
            _errorMessage = "Ce professeur n'est pas encore inscrit. Veuillez créer un compte.";
          });
        } else {
          setState(() {
            _errorMessage = "Mot de passe incorrect.";
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.school, color: AppTheme.primary),
            const SizedBox(width: 8),
            Text(
              'EduBurkina',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image Hero
                  Container(
                    height: 260, // Augmenté pour mieux voir l'image (la chaise, etc.)
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCIRNyiRfDmPIde7foYkHpIfDrxgL4UfSnmlo7S72g93v7dOOPHeeSOK-lv4CAXZSHFOZ_8mONE0u4IuAYmfbeSwCRFJIp-pnogndwvDy91OQW9Xzv1HOweRZyg5dn6GUqYP9tArj7gSynv09lhd4ffvc5qj8loT_uuIu7GJTSIIBkHtWRMG2PVSncjgTylu21JVW-cuIGSQv3FZUhN4JW7f_pHp6zL4BaHsvQ4sommLh_tPDPKDMbqQJU4xAxzSyH0ljvez_NWcdrI'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Titres
                  Text(
                    'Connexion',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Bienvenue sur votre portail professionnel.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Message d'erreur s'il y a lieu
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
                  
                  // Formulaire
                  Container(
                    padding: const EdgeInsets.all(20),
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Champ Nom d'utilisateur
                        Text(
                          'NOM D\'UTILISATEUR',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: 'Entrez votre identifiant',
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppTheme.outlineVariant),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppTheme.primaryContainer),
                            ),
                          ),
                          validator: (value) => value!.isEmpty ? 'Requis' : null,
                        ),
                        const SizedBox(height: 16),
                        
                        // Champ Mot de passe
                        Text(
                          'MOT DE PASSE',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: '••••••••',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                              onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppTheme.outlineVariant),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppTheme.primaryContainer),
                            ),
                          ),
                          validator: (value) => value!.isEmpty ? 'Requis' : null,
                        ),
                        
                        // Mot de passe oublié
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => AppFeedback.forgotPasswordDialog(context),
                            child: const Text('Mot de passe oublié ?', style: TextStyle(color: AppTheme.primary)),
                          ),
                        ),
                        
                        // Bouton Connexion
                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryContainer,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Se connecter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Inscription Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Pas encore de compte ? ', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                        },
                        child: const Text('S\'inscrire', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Lien temporaire Ecole
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SchoolLoginPage()));
                    },
                    child: const Text(
                      'Accès École',
                      style: TextStyle(color: AppTheme.tertiary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
