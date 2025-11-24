import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Lokasi Store", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.map, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            const Text("Vapstore Rajaku Pusat", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Jl. Sudirman No. 1, Jakarta Pusat", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {}, // Nanti bisa disambung ke Google Maps
              icon: const Icon(Icons.directions, color: Colors.white),
              label: const Text("BUKA GOOGLE MAPS", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}