import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../theme/app_theme.dart';

class PostSubjectScreen extends StatefulWidget {
  const PostSubjectScreen({super.key});

  @override
  State<PostSubjectScreen> createState() => _PostSubjectScreenState();
}

class _PostSubjectScreenState extends State<PostSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedLevel = 'Lycée';
  String _selectedMatiere = 'Mathématiques';

  String? _uploadedFileName;
  String? _uploadedFileSize;
  bool _isUploading = false;
  bool _isSubmitting = false;

  final List<String> _levels = ['Primaire', 'Collège', 'Lycée', 'Université'];
  final List<String> _matieres = [
    'Mathématiques',
    'Physique-Chimie',
    'SVT',
    'Français',
    'Histoire-Géographie',
    'Anglais',
    'Philosophie'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _simulateFileUpload() async {
    setState(() {
      _isUploading = true;
    });
    // Simulate file picker loading delay
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      _uploadedFileName = 'sujet_examen_${_selectedMatiere.toLowerCase()}_${_selectedLevel.toLowerCase()}.pdf';
      _uploadedFileSize = '2.4 Mo';
      _isUploading = false;
    });
  }

  void _removeFile() {
    setState(() {
      _uploadedFileName = null;
      _uploadedFileSize = null;
    });
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    // Simulate API request delay
    await Future.delayed(const Duration(milliseconds: 1500));

    final user = AuthService.currentUser;
    final String fullName = user?.fullName ?? 'Jean Ouedraogo';
    final String username = user != null
        ? '@${fullName.toLowerCase().replaceAll(' ', '_')}'
        : '@jean_ouedraogo';

    final newPost = {
      'author': fullName,
      'username': username,
      'title': _titleController.text,
      'description': _descriptionController.text,
      'imageUrl': 'assets/image/sujet1.jpg', // Feed item placeholder
      'level': _selectedLevel,
    };

    if (mounted) {
      Navigator.pop(context, newPost);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Votre sujet "${_titleController.text}" a été publié !',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.brand,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Poster un sujet'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 680),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Page Title & Subtitle ---
                    const Text(
                      'Partagez un document d\'examen',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Remplissez les détails ci-dessous pour proposer votre sujet aux autres élèves.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // --- Form fields inside Card ---
                    Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: const BorderSide(color: AppColors.border, width: 1),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title field
                            const Text(
                              'Titre du sujet',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _titleController,
                              style: const TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                hintText: 'Ex: Mathématiques Baccalauréat 2026',
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(color: AppColors.border),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(color: AppColors.border),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(color: AppColors.brand, width: 1.5),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Veuillez saisir un titre';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Description field
                            const Text(
                              'Description / Consignes',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _descriptionController,
                              maxLines: 4,
                              style: const TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                hintText: 'Saisissez les détails sur le sujet, les questions clés ou des conseils de résolution...',
                                contentPadding: const EdgeInsets.all(16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(color: AppColors.border),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(color: AppColors.border),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(color: AppColors.brand, width: 1.5),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Veuillez saisir une description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Dropdowns Level & Matiere Row
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Niveau',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      DropdownButtonFormField<String>(
                                        value: _selectedLevel,
                                        items: _levels.map((level) {
                                          return DropdownMenuItem(
                                            value: level,
                                            child: Text(level, style: const TextStyle(fontSize: 14)),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          if (val != null) {
                                            setState(() {
                                              _selectedLevel = val;
                                            });
                                          }
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: const BorderSide(color: AppColors.border),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Matière',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      DropdownButtonFormField<String>(
                                        value: _selectedMatiere,
                                        items: _matieres.map((matiere) {
                                          return DropdownMenuItem(
                                            value: matiere,
                                            child: Text(matiere, style: const TextStyle(fontSize: 14)),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          if (val != null) {
                                            setState(() {
                                              _selectedMatiere = val;
                                            });
                                          }
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: const BorderSide(color: AppColors.border),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // File picker upload area
                            const Text(
                              'Document joint (PDF / Image)',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildUploadArea(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // --- Submission Action ---
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: FilledButton(
                        onPressed: _isSubmitting ? null : _submitForm,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.brand,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Poster le sujet',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.2,
                                ),
                              ),
                      ),
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

  Widget _buildUploadArea() {
    if (_isUploading) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: const Column(
          children: [
            CircularProgressIndicator(strokeWidth: 2, color: AppColors.brand),
            SizedBox(height: 12),
            Text(
              'Sélection du fichier...',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    if (_uploadedFileName != null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.brandLight.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.brand.withOpacity(0.2), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.picture_as_pdf_rounded,
                color: Colors.redAccent,
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
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _uploadedFileSize!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.cancel_rounded, color: Colors.grey),
              onPressed: _removeFile,
              tooltip: 'Supprimer',
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: _simulateFileUpload,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.brand.withOpacity(0.3),
            width: 1.5,
            style: BorderStyle.solid, // Simulated dashed border via clean solid accent
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.cloud_upload_outlined,
                color: AppColors.brand,
                size: 32,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Parcourir un document',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.brand,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'PDF, PNG, JPG jusqu\'à 10 Mo',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
