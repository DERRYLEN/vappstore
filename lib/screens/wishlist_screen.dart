import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_provider.dart';
import 'product_detail_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil data dari provider
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItems = wishlistProvider.wishlistItems;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Wishlist Saya", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: wishlistItems.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey[800]),
            const SizedBox(height: 20),
            const Text("Belum ada barang impian.", style: TextStyle(color: Colors.grey)),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final product = wishlistItems[index];
          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product['images'][0], // Ambil gambar pertama
                  width: 60, height: 60, fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => Container(width: 60, color: Colors.grey),
                ),
              ),
              title: Text(product['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text(product['price'], style: const TextStyle(color: Colors.amber)),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Hapus dari wishlist
                  wishlistProvider.toggleWishlist(product);
                },
              ),
              onTap: () {
                // Ke Detail Produk
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}