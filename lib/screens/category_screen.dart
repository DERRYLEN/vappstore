import 'package:flutter/material.dart';
import 'product_detail_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  final List<Map<String, dynamic>> allProducts;

  const CategoryScreen({
    super.key,
    required this.categoryName,
    required this.allProducts,
  });

  @override
  Widget build(BuildContext context) {
    // --- 1. LOGIKA PENYARINGAN (FILTER) BARU ---
    final List<Map<String, dynamic>> filteredProducts = allProducts.where((product) {

      // KHUSUS TOMBOL PROMO:
      // Hanya ambil produk yang punya 'originalPrice' (artinya barang diskon)
      if (categoryName == 'Promo') {
        return product['originalPrice'] != null;
      }

      // Untuk tombol lain (Device, Liquid, Accs), saring berdasarkan kategori
      return product['category'] == categoryName;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(categoryName, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: filteredProducts.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.percent, size: 80, color: Colors.grey), // Ikon Diskon
            const SizedBox(height: 20),
            Text(
              categoryName == 'Promo'
                  ? "Belum ada barang diskon saat ini."
                  : "Kategori ini masih kosong.",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65, // Ukuran disesuaikan agar harga coret muat
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];

          // Cek Diskon
          bool hasDiscount = product['originalPrice'] != null;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // GAMBAR
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        product['images'][0], // Ambil gambar pertama
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (ctx, err, stack) => Container(color: Colors.grey),
                      ),
                    ),
                  ),

                  // INFO PRODUK
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tag Promo (Jika ada)
                        if (product['tag'] != '')
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: Text(product['tag'], style: const TextStyle(color: Colors.white, fontSize: 10)),
                          ),
                        const SizedBox(height: 5),

                        // Nama
                        Text(product['name'],
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),

                        const SizedBox(height: 4),

                        // --- 2. TAMPILAN HARGA CORET ---
                        if (hasDiscount)
                          Text(
                            product['originalPrice'],
                            style: const TextStyle(
                              color: Colors.grey, // Warna teks redup
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough, // Garis Coret
                              decorationColor: Colors.red, // Warna Garis Merah
                              decorationThickness: 2.0, // Tebal garis
                            ),
                          ),

                        // Harga Jual
                        Text(product['price'],
                            style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}