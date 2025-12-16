import 'package:flutter/material.dart';
// Jika Paduka punya file detail, import di sini. Jika belum, buat di bawah.
import 'detail_product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // DATA PRODUK (Ganti Link Foto Asli di sini, Rajaku)
    final List<Map<String, String>> products = [
      {
        'name': 'Centaurus B80S AIO',
        'price': 'Rp 750.000',
        'image': 'https://via.placeholder.com/300?text=Centaurus', // GANTI LINK INI
      },
      {
        'name': 'Hotcig R233 Pro',
        'price': 'Rp 450.000',
        'image': 'https://via.placeholder.com/300?text=Hotcig', // GANTI LINK INI
      },
      {
        'name': 'Hexohm V3 Anodized',
        'price': 'Rp 3.000.000',
        'image': 'https://via.placeholder.com/300?text=Hexohm', // GANTI LINK INI
      },
      {
        'name': 'Thelema Quest',
        'price': 'Rp 550.000',
        'image': 'https://via.placeholder.com/300?text=Thelema', // GANTI LINK INI
      },
    ];

    return Scaffold(
      // APABILA DI SINI ADA 'bottomNavigationBar', HAPUS SEGERA!

      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Text("Toko Rajaku", style: TextStyle(color: Colors.white)),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.white),
          SizedBox(width: 16),
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Area
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/600x300?text=BANNER'), // Ganti Link Banner
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text("Rekomendasi", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Grid Produk
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    // NAVIGASI KE DETAIL (Klik Berfungsi!)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailProductPage(
                          name: product['name']!,
                          price: product['price']!,
                          imageUrl: product['image']!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar Produk
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              product['image']!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) => const Center(child: Icon(Icons.error, color: Colors.red)),
                            ),
                          ),
                        ),
                        // Info Produk
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), maxLines: 1),
                              Text(product['price']!, style: const TextStyle(color: Color(0xFFFFC107))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}