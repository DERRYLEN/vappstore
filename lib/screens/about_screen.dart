import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Tentang Kami", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Icon(Icons.vape_free, size: 100, color: Colors.amber)),
            const SizedBox(height: 20),
            const Text("Vapstore Rajaku", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text(
              "Kami adalah distributor vape terlengkap dan terpercaya sejak tahun 2024. Menyediakan berbagai macam device, liquid, dan aksesoris dengan harga terbaik.\n\nVisi kami adalah memberikan pengalaman vaping terbaik bagi seluruh vapers di Indonesia.",
              style: TextStyle(color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 30),
            const Text("Versi Aplikasi: 1.0.0", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}