import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/app_feedback.dart';

class PublishDocumentPage extends StatefulWidget {
  const PublishDocumentPage({super.key});

  @override
  State<PublishDocumentPage> createState() => _PublishDocumentPageState();
}

class _PublishDocumentPageState extends State<PublishDocumentPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();

  String? _selectedSubject;
  String? _selectedLevel;
  bool _freePreview = true;

  final List<String> _subjects = [
    'Mathématiques',
    'SVT',
    'Philosophie',
    'Français',
    'Anglais'
  ];

  final List<String> _levels = [
    'Terminale',
    '1ère',
    '2nde',
    '3ème',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Publier un Document',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppTheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppTheme.onSurfaceVariant),
            onPressed: () async {
              final action = await showModalBottomSheet<String>(
                context: context,
                builder: (ctx) => SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.save_outlined),
                        title: const Text('Enregistrer le brouillon'),
                        onTap: () => Navigator.pop(ctx, 'draft'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.preview_outlined),
                        title: const Text('Aperçu'),
                        onTap: () => Navigator.pop(ctx, 'preview'),
                      ),
                    ],
                  ),
                ),
              );
              if (!context.mounted) return;
              if (action == 'draft') {
                AppFeedback.snackBar(context, 'Brouillon enregistré (démo).');
              } else if (action == 'preview') {
                AppFeedback.snackBar(context, 'Aperçu (démo).');
              }
            },
          ),
        ],
      ),
      // We use Stack to put the background bubbles behind the content
      body: Stack(
        children: [
          _buildBackgroundBubbles(),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildUploadZone(),
                        const SizedBox(height: 32),
                        _buildFormFields(),
                      ],
                    ),
                  ),
                ),
              ),
              _buildBottomActionArea(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundBubbles() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primary.withValues(alpha: 0.1),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: -20,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.tertiaryContainer.withValues(alpha: 0.1),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadZone() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          AppFeedback.snackBar(
            context,
            'Sélection de fichier : intégrez file_picker ou image_picker pour une vraie importation.',
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(48),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.outlineVariant, style: BorderStyle.solid, width: 2),
            // Note: Use standard border since dashed border requires custom painter or package
          ),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppTheme.primaryContainer.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.picture_as_pdf,
                    size: 40,
                    color: AppTheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Glisser ou sélectionner un PDF',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Text(
                'Taille maximale : 20 Mo',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        _buildLabel('Titre du document'),
        TextFormField(
          controller: _titleController,
          decoration: _buildInputDecoration("Ex: Cours complet de Géométrie dans l'espace"),
          validator: (value) => value == null || value.isEmpty ? 'Requis' : null,
        ),
        const SizedBox(height: 16),

        // Subject
        _buildLabel('Matière'),
        DropdownButtonFormField<String>(
          initialValue: _selectedSubject,
          decoration: _buildInputDecoration('Sélectionner une matière').copyWith(
            suffixIcon: const Icon(Icons.expand_more, color: AppTheme.onSurfaceVariant),
          ),
          icon: const SizedBox.shrink(), // hide default icon to use suffixIcon
          items: _subjects.map((String subject) {
            return DropdownMenuItem<String>(
              value: subject,
              child: Text(subject),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedSubject = value),
          validator: (value) => value == null ? 'Requis' : null,
        ),
        const SizedBox(height: 16),

        // Level
        _buildLabel('Niveau scolaire'),
        DropdownButtonFormField<String>(
          initialValue: _selectedLevel,
          decoration: _buildInputDecoration('Sélectionner un niveau').copyWith(
            suffixIcon: const Icon(Icons.expand_more, color: AppTheme.onSurfaceVariant),
          ),
          icon: const SizedBox.shrink(), // hide default icon
          items: _levels.map((String level) {
            return DropdownMenuItem<String>(
              value: level,
              child: Text(level),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedLevel = value),
          validator: (value) => value == null ? 'Requis' : null,
        ),
        const SizedBox(height: 16),

        // Price
        _buildLabel('Prix de vente (min. 500 FCFA)'),
        TextFormField(
          controller: _priceController,
          keyboardType: TextInputType.number,
          decoration: _buildInputDecoration('2500').copyWith(
            suffixIcon: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                border: Border(left: BorderSide(color: AppTheme.outlineVariant)),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'FCFA',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          validator: (value) => value == null || value.isEmpty ? 'Requis' : null,
        ),
        const SizedBox(height: 16),

        // Toggle Switch
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Aperçu gratuit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '5 premières pages visibles',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _freePreview,
                activeTrackColor: AppTheme.primary,
                activeThumbColor: Colors.white,
                inactiveTrackColor: AppTheme.outlineVariant,
                onChanged: (value) => setState(() => _freePreview = value),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: AppTheme.onSurfaceVariant,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppTheme.outline),
      filled: true,
      fillColor: AppTheme.surfaceContainerLowest,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppTheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppTheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppTheme.primary, width: 2),
      ),
    );
  }

  Widget _buildBottomActionArea() {
    return Container(
      color: AppTheme.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // CTA Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Document soumis pour validation !'),
                        backgroundColor: AppTheme.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryContainer,
                  foregroundColor: AppTheme.onPrimaryContainer,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 8,
                  shadowColor: AppTheme.primaryContainer.withValues(alpha: 0.5),
                ),
                child: const Text(
                  'Soumettre pour validation',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
