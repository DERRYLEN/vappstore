import 'package:flutter/material.dart';

class WishlistProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _wishlistItems = [];

  List<Map<String, dynamic>> get wishlistItems => _wishlistItems;

  // Cek apakah barang sudah di-love?
  bool isExist(String productName) {
    final isExist = _wishlistItems.indexWhere((item) => item['name'] == productName);
    return isExist != -1;
  }

  // Fungsi Tambah/Hapus Love
  void toggleWishlist(Map<String, dynamic> product) {
    final isExist = _wishlistItems.indexWhere((item) => item['name'] == product['name']);

    if (isExist != -1) {
      // Jika sudah ada, hapus (Unlove)
      _wishlistItems.removeAt(isExist);
    } else {
      // Jika belum ada, tambahkan (Love)
      _wishlistItems.add(product);
    }
    notifyListeners();
  }
}