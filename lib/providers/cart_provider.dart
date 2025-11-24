import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  Map<String, CartItem> get selectedItems {
    final Map<String, CartItem> selected = {};
    _items.forEach((key, value) {
      if (value.isSelected) {
        selected[key] = value;
      }
    });
    return selected;
  }

  int get itemCount {
    return _items.length;
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, cartItem) {
      if (cartItem.isSelected) {
        total += cartItem.price * cartItem.quantity;
      }
    });
    return total;
  }

  void toggleSelection(String productId) {
    if (_items.containsKey(productId)) {
      _items[productId]!.isSelected = !_items[productId]!.isSelected;
      notifyListeners();
    }
  }

  void addItem(String productId, String title, int price, String image) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          image: existingCartItem.image,
          quantity: existingCartItem.quantity + 1,
          isSelected: existingCartItem.isSelected,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
            () => CartItem(
          id: DateTime.now().toString(),
          name: title,
          price: price,
          image: image,
          quantity: 1,
          isSelected: true,
        ),
      );
    }
    notifyListeners();
  }

  // --- PERUBAHAN ADA DI SINI ---
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    // Cek jika jumlah lebih dari 1, baru kurangi
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          image: existingCartItem.image,
          quantity: existingCartItem.quantity - 1,
          isSelected: existingCartItem.isSelected,
        ),
      );
      notifyListeners(); // Update tampilan
    }
    // JIKA JUMLAH SUDAH 1, KITA DIAMKAN SAJA (TIDAK ADA ELSE/REMOVE)
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearPaidItems() {
    _items.removeWhere((key, value) => value.isSelected);
    notifyListeners();
  }

  void clearAll() {
    _items.clear();
    notifyListeners();
  }

  static int parsePrice(String priceString) {
    String cleanString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleanString) ?? 0;
  }
}