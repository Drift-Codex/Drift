import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/admin_colors.dart';

class AdminCreateSubjectScreen extends StatelessWidget {
  const AdminCreateSubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.background,
      appBar: AppBar(
        backgroundColor: AdminColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AdminColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Nouveau sujet', style: TextStyle(color: AdminColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Titre du sujet'),
            const SizedBox(height: 8),
            _buildTextField('Ex: Mathématiques - Équations du 2nd degré'),
            const SizedBox(height: 20),

            _buildLabel('Niveau'),
            const SizedBox(height: 8),
            _buildDropdown('Sélectionner le niveau'),
            const SizedBox(height: 20),

            _buildLabel('Matière'),
            const SizedBox(height: 8),
            _buildDropdown('Sélectionner la matière'),
            const SizedBox(height: 20),

            _buildLabel('Catégorie'),
            const SizedBox(height: 8),
            _buildDropdown('Sélectionner la catégorie'),
            const SizedBox(height: 20),

            _buildLabel('Description'),
            const SizedBox(height: 8),
            _buildTextArea('Décrivez ce sujet en quelques mots...', 5),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerRight,
              child: Text('0/200', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
            const SizedBox(height: 24),

            _buildLabel('Fichier du sujet'),
            const SizedBox(height: 8),
            _buildFileUploadArea(),
            const SizedBox(height: 24),

            _buildLabel('Image de couverture (optionnelle)'),
            const SizedBox(height: 8),
            _buildImageUploadArea(),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AdminColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Publier le sujet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AdminColors.textPrimary),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AdminColors.primary)),
      ),
    );
  }

  Widget _buildDropdown(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: const [],
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget _buildTextArea(String hint, int maxLines) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AdminColors.primary)),
      ),
    );
  }

  Widget _buildFileUploadArea() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AdminColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        // Une bordure pointillée nécessiterait un package externe (ex: dotted_border), on utilise une bordure simple pour l'instant
        border: Border.all(color: AdminColors.primary.withOpacity(0.5), width: 1.5),
      ),
      child: Column(
        children: [
          const Icon(Icons.cloud_upload_outlined, size: 40, color: AdminColors.primary),
          const SizedBox(height: 16),
          RichText(
            text: const TextSpan(
              style: TextStyle(color: AdminColors.textPrimary, fontSize: 14),
              children: [
                TextSpan(text: 'Déposer le fichier ici\n'),
                TextSpan(text: 'ou parcourir', style: TextStyle(color: AdminColors.primary, fontWeight: FontWeight.bold)),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text('PDF uniquement, max 10 Mo', style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildImageUploadArea() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.primary.withOpacity(0.5)),
      ),
      child: const Center(
        child: Text('Ajouter une image', style: TextStyle(color: AdminColors.primary, fontWeight: FontWeight.bold, fontSize: 14)),
      ),
    );
  }
}
