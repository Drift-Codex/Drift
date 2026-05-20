import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/admin_colors.dart';

class AdminSocialLinksScreen extends StatelessWidget {
  const AdminSocialLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.background,
      appBar: AppBar(
        backgroundColor: AdminColors.background,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AdminColors.textPrimary), onPressed: () => context.pop()),
        title: const Text('Réseaux sociaux', style: TextStyle(color: AdminColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSocialInput('Facebook', 'https://facebook.com/nafaedu', Icons.facebook, Colors.blue.shade800),
            const SizedBox(height: 20),
            _buildSocialInput('Twitter', 'https://twitter.com/nafaedu', Icons.alternate_email, Colors.lightBlue),
            const SizedBox(height: 20),
            _buildSocialInput('LinkedIn', 'https://linkedin.com/company/nafaedu', Icons.business, Colors.blue.shade700),
            const SizedBox(height: 20),
            _buildSocialInput('Instagram', 'https://instagram.com/nafaedu', Icons.camera_alt, Colors.pink),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: AdminColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('Enregistrer', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialInput(String label, String initialValue, IconData icon, Color iconColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
          ),
        ),
      ],
    );
  }
}
