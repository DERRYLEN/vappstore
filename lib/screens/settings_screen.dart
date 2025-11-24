import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Pengaturan Akun", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          _buildSettingItem(Icons.notifications, "Notifikasi Promo", true),
          _buildSettingItem(Icons.lock, "Ubah Password", false),
          _buildSettingItem(Icons.language, "Bahasa", false),
          _buildSettingItem(Icons.dark_mode, "Mode Gelap", true),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text("Hapus Akun", style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, bool isSwitch) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: isSwitch
          ? Switch(value: true, onChanged: (val){}, activeColor: Colors.red)
          : const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}