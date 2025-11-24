import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import semua Otak (Provider)
import 'providers/cart_provider.dart';
import 'providers/wishlist_provider.dart';
import 'providers/order_provider.dart'; // Pastikan file ini sudah dibuat
// Import Layar Awal
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiProvider memungkinkan aplikasi punya banyak "Otak"
    return MultiProvider(
      providers: [
        // 1. Otak Keranjang
        ChangeNotifierProvider(create: (context) => CartProvider()),

        // 2. Otak Wishlist (Love)
        ChangeNotifierProvider(create: (context) => WishlistProvider()),

        // 3. Otak Riwayat Pesanan (BARU)
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Hilangkan pita Debug
        title: 'Vapstore Rajaku',

        // Tema Global Aplikasi (Hitam & Merah)
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.red,
          scaffoldBackgroundColor: Colors.black,
          colorScheme: const ColorScheme.dark(
            primary: Colors.red,
            secondary: Colors.amber,
            surface: Colors.black,
          ),
          useMaterial3: true,
        ),

        // Pintu Masuk Utama
        home: const SplashScreen(),
      ),
    );
  }
}