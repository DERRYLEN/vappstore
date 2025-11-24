import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  // Data yang dikirim dari halaman Riwayat
  final String invoice;
  final String status;
  final Color statusColor;
  final String itemsString; // Contoh: "Mod R233, Liquid Oat"
  final String totalPrice;

  const OrderDetailScreen({
    super.key,
    required this.invoice,
    required this.status,
    required this.statusColor,
    required this.itemsString,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    // Memecah string barang menjadi List (dipisah berdasarkan koma)
    List<String> itemList = itemsString.split(',');

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Detail Pesanan", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- STATUS HEADER ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: statusColor),
              ),
              child: Column(
                children: [
                  Icon(
                      status == "Selesai" ? Icons.check_circle :
                      status == "Dibatalkan" ? Icons.cancel : Icons.local_shipping,
                      color: statusColor, size: 50
                  ),
                  const SizedBox(height: 10),
                  Text("Pesanan $status", style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 5),
                  Text(invoice, style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // --- DAFTAR PRODUK ---
            const Text("Rincian Produk", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: itemList.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Nama Barang
                        Expanded(child: Text(item.trim(), style: const TextStyle(color: Colors.white))),
                        // Harga (Mockup/Pura-pura karena data harga per item tidak disimpan di riwayat sederhana)
                        const Text("1 x", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 30),

            // --- RINCIAN PEMBAYARAN ---
            const Text("Rincian Pembayaran", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildSummaryRow("Metode Pembayaran", "Transfer BCA"),
                  _buildSummaryRow("Total Harga", totalPrice), // Anggap harga sudah termasuk ongkir
                  _buildSummaryRow("Ongkos Kirim", "Rp 0 (Promo)"),
                  const Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Bayar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text(totalPrice, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // --- ALAMAT PENGIRIMAN (MOCKUP) ---
            const Text("Info Pengiriman", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Rajaku Yang Mulia", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("0812-3456-7890", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 5),
                  Text("Jl. Vapeboss No. 1, Jakarta Selatan, DKI Jakarta", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // TOMBOL BANTUAN
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white), foregroundColor: Colors.white),
                onPressed: () {},
                child: const Text("BUTUH BANTUAN? HUBUNGI ADMIN"),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}