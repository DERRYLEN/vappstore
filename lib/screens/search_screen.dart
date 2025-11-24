import 'package:flutter/material.dart';
import 'product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, dynamic>> allProducts;

  const SearchScreen({super.key, required this.allProducts});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // List untuk menampung hasil pencarian
  List<Map<String, dynamic>> _foundProducts = [];

  @override
  void initState() {
    // Awalnya, tampilkan semua produk
    _foundProducts = widget.allProducts;
    super.initState();
  }

  // Fungsi Logika Pencarian
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // Jika kosong, tampilkan semua
      results = widget.allProducts;
    } else {
      // Jika mengetik, cari yang namanya mengandung kata kunci (case insensitive)
      results = widget.allProducts
          .where((product) =>
          product['name'].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Update tampilan
    setState(() {
      _foundProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        // Input Pencarian di AppBar
        title: TextField(
          onChanged: (value) => _runFilter(value),
          style: const TextStyle(color: Colors.white),
          autofocus: true, // Keyboard langsung muncul
          decoration: const InputDecoration(
            hintText: 'Cari produk...',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      ),
      body: _foundProducts.isEmpty
          ? const Center(child: Text("Produk tidak ditemukan", style: TextStyle(color: Colors.grey)))
          : ListView.builder(
        itemCount: _foundProducts.length,
        itemBuilder: (context, index) {
          final product = _foundProducts[index];
          return ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product['images'][0],
                width: 50, height: 50, fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) => const Icon(Icons.image, color: Colors.grey),
              ),
            ),
            title: Text(product['name'], style: const TextStyle(color: Colors.white)),
            subtitle: Text(product['price'], style: const TextStyle(color: Colors.amber)),
            onTap: () {
              // Ke Detail Produk
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}