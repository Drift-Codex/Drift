import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (_isComplete) {
      _handleSubmit();
    }
  }

  void _onKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  bool get _isComplete =>
      _controllers.every((c) => c.text.isNotEmpty);

  String get _otpValue => _controllers.map((c) => c.text).join();

  void _handleSubmit() {
    if (_isComplete) {
      context.go('/dashboard');
    }
  }

  void _handleResend() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Code renvoyé !'),
        backgroundColor: AppColors.brand,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
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

              Expanded(
                child: Center(
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Back button
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () => context.pop(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.arrow_back_rounded,
                                      size: 18, color: AppColors.textSecondary),
                                  const SizedBox(width: 4),
                                  Text('Retour',
                                      style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 14)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Shield icon
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: AppColors.brandLight,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.shield_rounded,
                                color: AppColors.brand, size: 32),
                          ),
                          const SizedBox(height: 20),

                          Text('Vérification',
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary)),
                          const SizedBox(height: 8),
                          Text.rich(
                            TextSpan(
                              text: 'Entrez le code à 6 chiffres envoyé à\n',
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.textSecondary),
                              children: [
                                TextSpan(
                                  text: '+226 XX XX XX XX',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),

                          // OTP Fields
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(6, (index) {
                              return Container(
                                width: 48,
                                height: 56,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                child: KeyboardListener(
                                  focusNode: FocusNode(),
                                  onKeyEvent: (event) => _onKeyEvent(index, event),
                                  child: TextField(
                                    controller: _controllers[index],
                                    focusNode: _focusNodes[index],
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                    decoration: InputDecoration(
                                      counterText: '',
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            BorderSide(color: AppColors.border, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            BorderSide(color: AppColors.brand, width: 2),
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    onChanged: (v) => _onChanged(index, v),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 24),

                          // Resend
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Vous n'avez pas reçu le code ? ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textSecondary)),
                              GestureDetector(
                                onTap: _handleResend,
                                child: Text('Renvoyer',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.brand,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Submit
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isComplete ? _handleSubmit : null,
                              child: const Text('Vérifier'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
