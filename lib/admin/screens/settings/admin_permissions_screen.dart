import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/admin_colors.dart';

class AdminPermissionsScreen extends StatefulWidget {
  const AdminPermissionsScreen({super.key});

  @override
  State<AdminPermissionsScreen> createState() => _AdminPermissionsScreenState();
}

class _AdminPermissionsScreenState extends State<AdminPermissionsScreen> {
  bool val1 = true;
  bool val2 = true;
  bool val3 = false;
  bool val4 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.background,
      appBar: AppBar(
        backgroundColor: AdminColors.background,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AdminColors.textPrimary), onPressed: () => context.pop()),
        title: const Text('Permissions', style: TextStyle(color: AdminColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSwitchTile('Gestion des utilisateurs', 'Autoriser la suppression et la modification d\'utilisateurs', val1, (v) => setState(() => val1 = v)),
          const Divider(),
          _buildSwitchTile('Modération des sujets', 'Approuver ou rejeter les sujets soumis', val2, (v) => setState(() => val2 = v)),
          const Divider(),
          _buildSwitchTile('Bannissement d\'IP', 'Autoriser le blocage d\'adresses IP', val3, (v) => setState(() => val3 = v)),
          const Divider(),
          _buildSwitchTile('Accès aux statistiques', 'Voir les rapports de croissance et d\'activité', val4, (v) => setState(() => val4 = v)),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AdminColors.textPrimary)),
      subtitle: Text(subtitle, style: const TextStyle(color: AdminColors.textSecondary, fontSize: 12)),
      value: value,
      onChanged: onChanged,
      activeColor: AdminColors.primary,
    );
  }
}
