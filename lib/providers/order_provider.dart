import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/cart_item.dart';

class OrderProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get orders => _orders;

  // Menerima Map<String, CartItem>
  void addOrder(Map<String, CartItem> cartItems, int totalAmount, String paymentMethod) {
    final date = DateTime.now();
    final invoiceNumber = "INV/${DateFormat('yyyyMMdd').format(date)}/${date.millisecond}";

    // Ambil nama barang dari values map
    String itemsSummary = cartItems.values.map((item) => "${item.name} (${item.quantity})").join(', ');

    final newOrder = {
      'invoice': invoiceNumber,
      'status': 'Dikemas',
      'statusColor': Colors.blue,
      'items': itemsSummary,
      'total': NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(totalAmount),
      'payment': paymentMethod,
      'date': DateFormat('dd MMM yyyy, HH:mm').format(date),
    };

    _orders.insert(0, newOrder);
    notifyListeners();
  }
}