import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data Pura-pura (Dummy)
    final List<Map<String, String>> notifications = [
      {
        'title': 'Promo Flash Sale 12.12!',
        'body': 'Dapatkan diskon hingga 50% untuk semua Liquid Creamy.',
        'time': 'Baru Saja',
        'type': 'promo'
      },
      {
        'title': 'Pesanan Sedang Dikemas',
        'body': 'Paket Mod R233 Anda sedang disiapkan oleh admin.',
        'time': '1 Jam yang lalu',
        'type': 'order'
      },
      {
        'title': 'Stok Hexohm Masuk!',
        'body': 'Barang langka sudah ready stock lagi, jangan sampai kehabisan.',
        'time': 'Kemarin',
        'type': 'info'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Notifikasi", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[800]!),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: notif['type'] == 'promo' ? Colors.red : Colors.blue,
                child: Icon(
                  notif['type'] == 'promo' ? Icons.discount : Icons.local_shipping,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              title: Text(
                notif['title']!,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(notif['body']!, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text(notif['time']!, style: TextStyle(color: Colors.grey[600], fontSize: 10)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}