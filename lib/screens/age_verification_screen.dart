import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Diperlukan untuk SystemNavigator
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class AgeVerificationScreen extends StatelessWidget {
  const AgeVerificationScreen({super.key});

  // Fungsi saat tombol YA ditekan
  Future<void> _confirmAge(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    // Simpan data bahwa user sudah dewasa
    await prefs.setBool('isAdult', true);

    if (context.mounted) {
      // Pindah ke Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.no_adult_content, size: 100, color: Colors.red),
              const SizedBox(height: 30),

              const Text(
                "VERIFIKASI UMUR",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "Anda harus berusia 18 tahun ke atas untuk mengakses aplikasi ini. Produk mengandung nikotin.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 50),

              // Tombol YA
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[900],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => _confirmAge(context),
                  child: const Text(
                    "SAYA BERUSIA 18+",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Tombol TIDAK
              TextButton(
                onPressed: () {
                  // Keluar aplikasi
                  SystemNavigator.pop();
                },
                child: const Text(
                  "TIDAK, KELUAR",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}