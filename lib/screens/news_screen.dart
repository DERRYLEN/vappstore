import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Vape News", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true, // Judul di tengah agar rapi

        // --- PERBAIKAN UTAMA DI SINI ---
        // Kita tambahkan tombol Back secara manual
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Logika Cerdas:
            // Jika halaman ini bisa 'mundur' (misal dibuka dari Drawer), maka mundur.
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              // Jika tidak bisa mundur (misal sedang di Tab Bawah),
              // kita biarkan saja atau bisa beri notifikasi
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Anda sudah di halaman utama News")),
              );
            }
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _buildNewsItem("Tips Merawat Coil Agar Awet", "10 Menit lalu", Colors.red),
          _buildNewsItem("Liquid Creamy vs Fruity, Mana Pilihanmu?", "1 Jam lalu", Colors.blue),
          _buildNewsItem("Regulasi Vape Terbaru 2025", "Kemarin", Colors.orange),
          _buildNewsItem("Review Mod R233: Si Kecil Cabe Rawit", "2 Hari lalu", Colors.green),
          _buildNewsItem("Cara Wicking yang Benar", "3 Hari lalu", Colors.purple),
          _buildNewsItem("Vape Fair 2025: Jadwal & Lokasi", "Minggu lalu", Colors.teal),
        ],
      ),
    );
  }

  Widget _buildNewsItem(String title, String time, Color color) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.article, color: color),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ),
        onTap: () {
          // Nanti bisa ditambah navigasi ke detail berita
        },
      ),
    );
  }
}