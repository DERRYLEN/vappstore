import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../providers/order_provider.dart'; // Import Otak Pesanan
import 'order_detail_screen.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil data ASLI dari OrderProvider
    final orderData = Provider.of<OrderProvider>(context);
    final orders = orderData.orders;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Riwayat Pesanan", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // Jika data kosong -> Tampilkan Pesan Kosong
      body: orders.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 80, color: Colors.grey[800]),
            const SizedBox(height: 20),
            const Text("Belum ada riwayat pesanan.", style: TextStyle(color: Colors.grey)),
          ],
        ),
      )
      // Jika ada data -> Tampilkan List
          : ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _buildOrderItem(
            context,
            order['invoice'],
            order['status'],
            order['statusColor'],
            order['items'],
            order['total'],
          );
        },
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, String inv, String status, Color color, String items, String price) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailScreen(
              invoice: inv,
              status: status,
              statusColor: color,
              itemsString: items,
              totalPrice: price,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[800]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(inv, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                  child: Text(status, style: TextStyle(color: color, fontSize: 12)),
                ),
              ],
            ),
            const Divider(color: Colors.grey),
            Text(items, style: const TextStyle(color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Belanja", style: TextStyle(color: Colors.white)),
                Text(price, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}