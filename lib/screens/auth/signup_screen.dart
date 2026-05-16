import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  bool _acceptTerms = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate() && _acceptTerms) {
      context.go('/auth/otp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.brandLight, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.go('/'),
                      child: Row(
                        children: [
                          Icon(Icons.school_rounded, color: AppColors.brand, size: 28),
                          const SizedBox(width: 8),
                          Text('Nafa Edu',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: AppColors.textPrimary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Form
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Créer un compte',
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary)),
                          const SizedBox(height: 8),
                          Text('Rejoignez Nafa Edu gratuitement',
                              style: TextStyle(
                                  fontSize: 15, color: AppColors.textSecondary)),
                          const SizedBox(height: 24),

                          // Full Name
                          _buildLabel('Nom complet'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Jean Ouedraogo',
                              prefixIcon: Icon(Icons.person_outline_rounded,
                                  color: AppColors.textTertiary),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Nom requis' : null,
                          ),
                          const SizedBox(height: 16),

                          // Email
                          _buildLabel('Adresse email'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'exemple@email.com',
                              prefixIcon: Icon(Icons.mail_outline_rounded,
                                  color: AppColors.textTertiary),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Email requis' : null,
                          ),
                          const SizedBox(height: 16),

                          // Phone
                          _buildLabel('Numéro de téléphone'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: '+226 XX XX XX XX',
                              prefixIcon: Icon(Icons.phone_outlined,
                                  color: AppColors.textTertiary),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Téléphone requis' : null,
                          ),
                          const SizedBox(height: 16),

                          // Password
                          _buildLabel('Mot de passe'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              hintText: '••••••••',
                              prefixIcon: Icon(Icons.lock_outline_rounded,
                                  color: AppColors.textTertiary),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.textTertiary,
                                ),
                                onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword),
                              ),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Mot de passe requis' : null,
                          ),
                          const SizedBox(height: 16),

                          // Confirm Password
                          _buildLabel('Confirmer le mot de passe'),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              hintText: '••••••••',
                              prefixIcon: Icon(Icons.lock_outline_rounded,
                                  color: AppColors.textTertiary),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Confirmation requise';
                              }
                              if (v != _passwordController.text) {
                                return 'Les mots de passe ne correspondent pas';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Terms
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                  value: _acceptTerms,
                                  onChanged: (v) =>
                                      setState(() => _acceptTerms = v ?? false),
                                  activeColor: AppColors.brand,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    text: "J'accepte les ",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary),
                                    children: [
                                      TextSpan(
                                        text: "conditions d'utilisation",
                                        style: TextStyle(color: AppColors.brand),
                                      ),
                                      const TextSpan(text: ' et la '),
                                      TextSpan(
                                        text: 'politique de confidentialité',
                                        style: TextStyle(color: AppColors.brand),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Submit
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _acceptTerms ? _handleSubmit : null,
                              child: const Text('Créer mon compte'),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Login link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Vous avez déjà un compte ? ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textSecondary)),
                              GestureDetector(
                                onTap: () => context.go('/auth/login'),
                                child: Text('Connectez-vous',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.brand,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Footer
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('© 2026 Nafa Edu. Tous droits réservés.',
                    style: TextStyle(fontSize: 12, color: AppColors.textTertiary)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary)),
    );
  }
}
