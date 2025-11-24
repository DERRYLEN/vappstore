import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/cart_provider.dart';
import 'payment_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Keranjang Belanja", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              // Hapus Semua (Kosongkan)
              Provider.of<CartProvider>(context, listen: false).clearAll();
            },
            tooltip: "Hapus Semua",
          )
        ],
      ),

      body: Consumer<CartProvider>(
        builder: (context, cart, child) {

          if (cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey[800]),
                  const SizedBox(height: 20),
                  const Text("Keranjang masih kosong.", style: TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cart.items.values.toList()[index];
                    final productId = cart.items.keys.toList()[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          // 1. CHECKBOX PILIH BARANG
                          Checkbox(
                            value: cartItem.isSelected,
                            activeColor: Colors.red, // Warna Merah
                            side: const BorderSide(color: Colors.white),
                            checkColor: Colors.white,
                            onChanged: (bool? value) {
                              // Ubah status centang
                              Provider.of<CartProvider>(context, listen: false).toggleSelection(productId);
                            },
                          ),

                          // 2. KARTU PRODUK
                          Expanded(
                            child: Card(
                              color: Colors.grey[900],
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    // Gambar
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        cartItem.image,
                                        width: 70, height: 70, fit: BoxFit.cover,
                                        errorBuilder: (ctx, err, stack) => Container(width: 70, height: 70, color: Colors.grey),
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    // Info & Counter
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              cartItem.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                              currencyFormat.format(cartItem.price),
                                              style: const TextStyle(color: Colors.amber, fontSize: 12)
                                          ),
                                          const SizedBox(height: 8),

                                          // Tombol Counter (+/-)
                                          Row(
                                            children: [
                                              _buildQtyBtn(icon: Icons.remove, onTap: () => cart.removeSingleItem(productId)),
                                              Container(
                                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                                child: Text("${cartItem.quantity}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                              ),
                                              _buildQtyBtn(icon: Icons.add, onTap: () => cart.addItem(productId, cartItem.name, cartItem.price, cartItem.image)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // BAGIAN BAWAH (TOTAL & CHECKOUT)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))]
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total Dipilih:", style: TextStyle(color: Colors.white, fontSize: 16)),
                        Text(
                            currencyFormat.format(cart.totalAmount),
                            style: const TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[800],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                        ),
                        onPressed: () {
                          // VALIDASI: Cek apakah ada yang dicentang?
                          if (cart.totalAmount <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pilih minimal 1 barang!"), backgroundColor: Colors.red));
                            return;
                          }
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentScreen()));
                        },
                        child: Text("CHECKOUT (${currencyFormat.format(cart.totalAmount)})", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQtyBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey)),
        child: Icon(icon, color: Colors.white, size: 14),
      ),
    );
  }
}