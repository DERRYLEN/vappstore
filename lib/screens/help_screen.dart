import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Pusat Bantuan", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const Text("Pertanyaan Umum (FAQ)", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          _buildFaqItem("Bagaimana cara melacak pesanan?", "Anda bisa melihat status pesanan di menu Riwayat Pesanan."),
          _buildFaqItem("Apakah barang dijamin otentik?", "Ya, semua barang di Tokovape 100% Authentic dan bergaransi."),
          _buildFaqItem("Berapa lama pengiriman?", "Untuk Jabodetabek 1-2 hari, luar pulau 3-5 hari kerja."),
          _buildFaqItem("Bagaimana cara retur barang?", "Sertakan video unboxing dan hubungi admin via WhatsApp."),

          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
              icon: const Icon(Icons.chat),
              label: const Text("CHAT ADMIN WHATSAPP"),
              onPressed: (){},
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(color: Colors.white, fontSize: 14)),
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(answer, style: const TextStyle(color: Colors.grey)),
          )
        ],
      ),
    );
  }
}