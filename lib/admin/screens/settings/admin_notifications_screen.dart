import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/admin_colors.dart';

class AdminNotificationsScreen extends StatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  State<AdminNotificationsScreen> createState() => _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState extends State<AdminNotificationsScreen> {
  bool push1 = true;
  bool push2 = false;
  bool email1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.background,
      appBar: AppBar(
        backgroundColor: AdminColors.background,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AdminColors.textPrimary), onPressed: () => context.pop()),
        title: const Text('Notifications', style: TextStyle(color: AdminColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Notifications Push', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AdminColors.primary)),
          const SizedBox(height: 8),
          SwitchListTile(title: const Text('Nouveau sujet soumis'), value: push1, activeColor: AdminColors.primary, onChanged: (v) => setState(() => push1 = v)),
          SwitchListTile(title: const Text('Nouvel utilisateur inscrit'), value: push2, activeColor: AdminColors.primary, onChanged: (v) => setState(() => push2 = v)),
          const SizedBox(height: 24),
          const Text('Notifications Email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AdminColors.primary)),
          const SizedBox(height: 8),
          SwitchListTile(title: const Text('Rapport hebdomadaire'), value: email1, activeColor: AdminColors.primary, onChanged: (v) => setState(() => email1 = v)),
        ],
      ),
    );
  }
}
