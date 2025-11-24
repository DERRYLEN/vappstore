import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import 'order_history_screen.dart';
import 'address_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPayment = 'Transfer Bank (BCA)';
  String _userName = "User";
  String _addrPhone = "";
  String _addrStreet = "";
  String _addrCity = "";
  String _addrZip = "";
  bool _hasAddress = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? "Pelanggan Setia";
      _addrPhone = prefs.getString('addr_phone') ?? "";
      _addrStreet = prefs.getString('addr_street') ?? "";
      _addrCity = prefs.getString('addr_city') ?? "";
      _addrZip = prefs.getString('addr_zip') ?? "";
      _hasAddress = _addrStreet.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    // Total yang harus dibayar (Hanya yang dicentang)
    int amountToPay = cart.totalAmount;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Pembayaran", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Alamat Pengiriman", style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text("Ubah", style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressScreen())).then((_) => _loadUserData());
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _hasAddress ? Colors.grey[800]! : Colors.red),
                      ),
                      child: _hasAddress
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [Icon(Icons.location_on, color: Colors.red, size: 16), SizedBox(width: 5), Text(_userName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
                          const SizedBox(height: 5),
                          Text("$_addrStreet, $_addrCity", style: const TextStyle(color: Colors.grey, height: 1.3)),
                          const SizedBox(height: 5),
                          Text("Telp: $_addrPhone", style: const TextStyle(color: Colors.grey)),
                        ],
                      )
                          : Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.add_location_alt, color: Colors.red), SizedBox(width: 10), Text("Tambah Alamat Pengiriman", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text("Metode Pembayaran", style: TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 10),
                  _buildPaymentOption("Transfer Bank (BCA)", Icons.account_balance),
                  _buildPaymentOption("Transfer Bank (Mandiri)", Icons.account_balance),
                  _buildPaymentOption("COD (Bayar di Tempat)", Icons.local_shipping),
                  _buildPaymentOption("E-Wallet (GoPay/OVO)", Icons.wallet),

                  const SizedBox(height: 30),

                  const Text("Ringkasan Belanja", style: TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Total Harga Barang", style: TextStyle(color: Colors.grey)), Text(currencyFormat.format(amountToPay), style: const TextStyle(color: Colors.white))]),
                        const SizedBox(height: 10),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text("Ongkos Kirim", style: TextStyle(color: Colors.grey)), Text("Rp 0", style: TextStyle(color: Colors.green))]),
                        const Divider(color: Colors.grey, height: 30),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Total Tagihan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)), Text(currencyFormat.format(amountToPay), style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18))]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.grey[900], border: const Border(top: BorderSide(color: Colors.white10))),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red[800], foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  if (!_hasAddress) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Mohon isi alamat pengiriman terlebih dahulu!"), backgroundColor: Colors.red));
                    return;
                  }

                  // 1. PROSES BARANG YANG DICENTANG SAJA
                  Provider.of<OrderProvider>(context, listen: false).addOrder(
                    cart.selectedItems, // Ambil selected items
                    amountToPay,        // Ambil total selected
                    _selectedPayment,
                  );

                  // 2. HAPUS BARANG YANG SUDAH DIBAYAR SAJA
                  cart.clearPaidItems();

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: Colors.grey[900],
                      title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
                      content: const Text("Pembayaran Berhasil!\nPesanan Anda sedang diproses.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            Navigator.pop(context);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OrderHistoryScreen()));
                          },
                          child: const Text("LIHAT PESANAN SAYA", style: TextStyle(color: Colors.amber)),
                        )
                      ],
                    ),
                  );
                },
                child: const Text("BAYAR SEKARANG", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: _selectedPayment == title ? Colors.red.withOpacity(0.1) : Colors.grey[900], border: Border.all(color: _selectedPayment == title ? Colors.red : Colors.transparent), borderRadius: BorderRadius.circular(10)),
      child: RadioListTile<String>(title: Row(children: [Icon(icon, color: Colors.white, size: 20), const SizedBox(width: 10), Text(title, style: const TextStyle(color: Colors.white, fontSize: 14))]), value: title, groupValue: _selectedPayment, activeColor: Colors.red, onChanged: (value) => setState(() => _selectedPayment = value!)),
    );
  }
}