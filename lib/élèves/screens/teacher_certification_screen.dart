import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart';
import '../theme/app_theme.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.gap = 6.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(16),
      ));

    for (PathMetric metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final remaining = metric.length - distance;
        final nextDistance = distance + (remaining < gap ? remaining : gap);
        canvas.drawPath(
          metric.extractPath(distance, nextDistance),
          paint,
        );
        distance += gap * 2;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TeacherCertificationScreen extends StatefulWidget {
  const TeacherCertificationScreen({super.key});

  @override
  State<TeacherCertificationScreen> createState() => _TeacherCertificationScreenState();
}

class _TeacherCertificationScreenState extends State<TeacherCertificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _schoolController = TextEditingController();
  final _matriculeController = TextEditingController();

  String? _uploadedFileName;
  String? _uploadedFileSize;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Pre-populate with current user's name if logged in
    final currentUser = AuthService.currentUser;
    if (currentUser != null) {
      _nameController.text = currentUser.fullName;
      _schoolController.text = currentUser.school;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _schoolController.dispose();
    _matriculeController.dispose();
    super.dispose();
  }

  void _simulateFileUpload() {
    setState(() {
      _uploadedFileName = "carte_professionnelle_education.png";
      _uploadedFileSize = "2.4 Mo";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fichier sélectionné avec succès !'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _removeUploadedFile() {
    setState(() {
      _uploadedFileName = null;
      _uploadedFileSize = null;
    });
  }

  void _submitRequest() {
    if (!_formKey.currentState!.validate()) return;
    if (_uploadedFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez ajouter une pièce justificative.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Simulate submission lag
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      AuthService.requestTeacherAccess();
      setState(() {
        _isSubmitting = false;
      });

      // Show beautiful success popup
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Text('Demande reçue !'),
            ],
          ),
          content: const Text(
            'Votre demande de certification a été soumise avec succès. Nos équipes vont étudier vos pièces justificatives sous 48h.',
            style: TextStyle(height: 1.4),
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                context.pop(); // Go back to teacher portal
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.brand,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Fermer'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Text('Certification Enseignant'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 550),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- HEADER INTRODUCTION ---
                        Center(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF4F46E5).withOpacity(0.3),
                                      blurRadius: 16,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.school_rounded,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(height: 18),
                              const Text(
                                'Demande de statut Enseignant',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Rejoignez les enseignants certifiés pour publier des ressources d\'excellence, corriger des sujets officiels et proposer vos cours et documents sur le Marketplace.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: AppColors.textSecondary,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // --- INPUT FIELDS ---
                        const Text(
                          'Informations Professionnelles',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Nom complet
                        TextFormField(
                          controller: _nameController,
                          validator: (value) => value == null || value.trim().isEmpty
                              ? 'Veuillez saisir votre nom complet.'
                              : null,
                          decoration: InputDecoration(
                            labelText: 'Nom complet & Prénom',
                            prefixIcon: const Icon(Icons.person_outline_rounded),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: AppColors.border),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Établissement
                        TextFormField(
                          controller: _schoolController,
                          validator: (value) => value == null || value.trim().isEmpty
                              ? 'Veuillez renseigner votre établissement.'
                              : null,
                          decoration: InputDecoration(
                            labelText: 'Établissement actuel',
                            hintText: 'Ex: Lycée Philippe Zinda Kaboré',
                            prefixIcon: const Icon(Icons.location_city_rounded),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: AppColors.border),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Matricule Officiel
                        TextFormField(
                          controller: _matriculeController,
                          validator: (value) => value == null || value.trim().isEmpty
                              ? 'Veuillez renseigner votre numéro de matricule.'
                              : null,
                          decoration: InputDecoration(
                            labelText: 'Numéro de Matricule Officiel',
                            hintText: 'Ex: 245963-A',
                            prefixIcon: const Icon(Icons.badge_outlined),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: AppColors.border),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // --- FILE UPLOAD ZONE ---
                        const Text(
                          'Pièce Justificative',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),

                        _uploadedFileName == null
                            ? CustomPaint(
                                painter: DashedBorderPainter(color: AppColors.divider),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.cloud_upload_outlined,
                                        size: 38,
                                        color: AppColors.textTertiary,
                                      ),
                                      const SizedBox(height: 12),
                                      const Text(
                                        'Téléversez un justificatif',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      const Text(
                                        'Carte professionnelle, arrêté de nomination ou bulletin récent (PNG, JPG, PDF, max 10 Mo).',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          color: AppColors.textSecondary,
                                          height: 1.35,
                                        ),
                                      ),
                                      const SizedBox(height: 18),
                                      SizedBox(
                                        height: 38,
                                        child: ElevatedButton.icon(
                                          onPressed: _simulateFileUpload,
                                          icon: const Icon(Icons.camera_alt_outlined, size: 16),
                                          label: const Text('Choisir un fichier'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.brand,
                                            foregroundColor: Colors.white,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.12),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.insert_drive_file_rounded,
                                        color: Colors.green,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _uploadedFileName!,
                                            style: const TextStyle(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            _uploadedFileSize!,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _removeUploadedFile,
                                      icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                                      tooltip: 'Supprimer le fichier',
                                    ),
                                  ],
                                ),
                              ),
                        const SizedBox(height: 28),

                        // --- PRIVACY NOTE ---
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.brandLight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.shield_outlined,
                                  color: AppColors.brand,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  'Données hautement protégées : vos pièces administratives d\'identification sont cryptées de bout en bout et ne serviront qu\'à l\'authentification officielle de votre profil.',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    color: AppColors.textSecondary,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 36),

                        // --- SUBMISSION BUTTON ---
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: _isSubmitting
                              ? const Center(
                                  child: CircularProgressIndicator(color: AppColors.brand),
                                )
                              : FilledButton(
                                  onPressed: _submitRequest,
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.brand,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Text(
                                    'Soumettre ma demande',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
