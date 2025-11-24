import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import 'payment_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedVariantIndex = 0;
  int _currentImageIndex = 0;
  final List<String> _variants = ["3mg", "6mg", "9mg", "12mg", "Freebase"];

  @override
  Widget build(BuildContext context) {
    // Cek Stok
    bool isOutOfStock = (widget.product['stock'] ?? 1) <= 0;

    final List<String> images = widget.product['images'] != null
        ? List<String>.from(widget.product['images'])
        : ['https://via.placeholder.com/300'];

    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final isLoved = wishlistProvider.isExist(widget.product['name']);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black54,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: Icon(isLoved ? Icons.favorite : Icons.favorite_border, color: isLoved ? Colors.red : Colors.white),
                onPressed: () {
                  wishlistProvider.toggleWishlist(widget.product);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isLoved ? "Dihapus dari Wishlist" : "Ditambahkan ke Wishlist"), backgroundColor: isLoved ? Colors.red : Colors.green, duration: const Duration(seconds: 1)));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  final String shareText = "Cek produk ${widget.product['name']} di Vapstore Rajaku! Harga: ${widget.product['price']}";
                  Clipboard.setData(ClipboardData(text: shareText));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Link produk disalin ke clipboard!")));
                },
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 400.0, viewportFraction: 1.0, enableInfiniteScroll: images.length > 1,
                          onPageChanged: (index, reason) => setState(() => _currentImageIndex = index),
                        ),
                        items: images.map((imgUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return SizedBox(width: double.infinity, child: Image.network(imgUrl, fit: BoxFit.cover, errorBuilder: (ctx, error, stack) => Container(color: Colors.grey[800], child: const Icon(Icons.broken_image, size: 50, color: Colors.white))));
                            },
                          );
                        }).toList(),
                      ),
                      if (images.length > 1)
                        Positioned(
                          bottom: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: images.asMap().entries.map((entry) {
                              return Container(width: 8.0, height: 8.0, margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0), decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(_currentImageIndex == entry.key ? 0.9 : 0.4)));
                            }).toList(),
                          ),
                        ),
                    ],
                  ),

                  Container(
                    transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.black, borderRadius: const BorderRadius.vertical(top: Radius.circular(30)), border: Border(top: BorderSide(color: Colors.grey[800]!, width: 1))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(10)))),
                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Text(widget.product['name'], style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (widget.product['originalPrice'] != null)
                                  Text(
                                    widget.product['originalPrice'],
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.red,
                                      decorationThickness: 3.0,
                                    ),
                                  ),
                                Text(widget.product['price'], style: const TextStyle(color: Colors.amber, fontSize: 22, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        Row(children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const Text(" 4.9 (85 Reviews)", style: TextStyle(color: Colors.grey)),
                          const Spacer(),
                          // LABEL STOK
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: isOutOfStock ? Colors.red.withOpacity(0.2) : Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: Text(
                                isOutOfStock ? "Stok Habis" : "Stok: ${widget.product['stock']}",
                                style: TextStyle(color: isOutOfStock ? Colors.red : Colors.green, fontSize: 12, fontWeight: FontWeight.bold)
                            ),
                          ),
                        ]),

                        const SizedBox(height: 25),
                        const Text("Pilih Varian:", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(_variants.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ChoiceChip(
                                  label: Text(_variants[index]),
                                  selected: _selectedVariantIndex == index,
                                  selectedColor: Colors.red[900],
                                  backgroundColor: Colors.grey[900],
                                  labelStyle: TextStyle(color: _selectedVariantIndex == index ? Colors.white : Colors.grey),
                                  onSelected: (bool selected) => setState(() => _selectedVariantIndex = index),
                                ),
                              );
                            }),
                          ),
                        ),

                        const SizedBox(height: 25),
                        const Text("Deskripsi Produk:", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        Text(widget.product['description'] ?? "Tidak ada deskripsi.", style: const TextStyle(color: Colors.grey, height: 1.6)),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- TOMBOL AKSI ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(color: Colors.grey[900], border: const Border(top: BorderSide(color: Colors.white10))),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                  child: IconButton(icon: const Icon(Icons.chat_bubble_outline, color: Colors.white), onPressed: () {}),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      onPressed: isOutOfStock ? null : () { // Disable jika habis
                        _addToCartLogic(context, images);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Masuk Keranjang!"), backgroundColor: Colors.green));
                      },
                      child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.shopping_cart_outlined, size: 18), Text("+ KERANJANG", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))]),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isOutOfStock ? Colors.grey : Colors.red[800], // Abu jika habis
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: isOutOfStock ? null : () { // Disable jika habis
                        _addToCartLogic(context, images);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentScreen()));
                      },
                      child: Text(isOutOfStock ? "HABIS" : "BELI SEKARANG", textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addToCartLogic(BuildContext context, List<String> images) {
    final productPrice = CartProvider.parsePrice(widget.product['price']);
    String thumbnail = (images.isNotEmpty) ? images[0] : '';

    Provider.of<CartProvider>(context, listen: false).addItem(
      widget.product['name'],
      widget.product['name'],
      productPrice,
      thumbnail,
    );
  }
}