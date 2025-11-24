import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'age_verification_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAgeStatus();
  }

  // Logika pengecekan umur
  Future<void> _checkAgeStatus() async {
    // 1. Simulasi loading (tunggu 2 detik biar logo terlihat)
    await Future.delayed(const Duration(seconds: 2));

    // 2. Cek memori HP
    final prefs = await SharedPreferences.getInstance();
    // Apakah ada data 'isAdult'? Jika tidak ada, anggap false.
    bool isAdult = prefs.getBool('isAdult') ?? false;

    if (!mounted) return;

    // 3. Arahkan user
    if (isAdult) {
      // Jika sudah dewasa -> Masuk Toko
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Jika belum verifikasi -> Hadang di Pintu Masuk
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AgeVerificationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder Logo (Ganti dengan Image.asset jika sudah ada logo)
            Icon(Icons.vape_free, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(
                "VAPSTORE RAJAKU",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(color: Colors.red),
          ],
        ),
      ),
    );
  }
}