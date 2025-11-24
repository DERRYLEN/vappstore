import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';
import 'category_screen.dart';
import 'search_screen.dart';
import 'notification_screen.dart';

import 'news_screen.dart';
import 'wishlist_screen.dart';
import 'account_screen.dart';
import 'location_screen.dart';
import 'about_screen.dart';
import 'contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const NewsScreen(),
    const WishlistScreen(),
    const AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'News'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
      ),
    );
  }
}

// ============================================================
// HOME CONTENT
// ============================================================
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<String> imgList = [
    'https://via.placeholder.com/600x300/8B0000/FFFFFF?text=PROMO+MERDEKA+50%',
    'https://via.placeholder.com/600x300/000000/FFFFFF?text=NEW+ARRIVAL+PODS',
    'https://via.placeholder.com/600x300/FFA500/000000?text=LIQUID+CREAMY+ENAK',
  ];

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.vape_free, 'name': 'Device'},
    {'icon': Icons.water_drop, 'name': 'Liquid'},
    {'icon': Icons.usb, 'name': 'Accs'},
    {'icon': Icons.discount, 'name': 'Promo'},
  ];

  // --- DATA PRODUK ASLI ---
  final List<Map<String, dynamic>> products = [
    // --- DEVICE ---
    {
      'name': 'Hotcig R99 Uncommon Mod Kit Authentic',
      'price': 'Rp 450.000',
      'originalPrice': 'Rp 600.000',
      'category': 'Device',
      'stock': 5,
      'images': [
        'https://vapeboss.co.id/assets/Product/20251114/R99-Uncommon-A-Bliss-1-v2__FillWzU0MCwzNDJd.png',
        'https://vapeboss.co.id/assets/Product/20251114/R99-Uncommon-Limea-1-v2__FillWzM1NSwzNTVd.png',
      ],
      'tag': 'Hot',
      'description': 'Mod kit dengan desain transparan yang unik dan chipset tangguh HM Chip. Tahan air dan debu ringan.\n\nSpesifikasi:\n- Power: 5-80W\n- Battery: Single 18650 (exclude)\n- Material: PC + Zinc Alloy'
    },
    {
      'name': 'Centaurus B80S Aio Kit Authentic',
      'price': 'Rp 750.000',
      'category': 'Device',
      'stock': 3,
      'images': [
        'https://vapeboss.co.id/assets/Product/20250527/B80s__FillWzM1NSwzNTVd.jpg',
      ],
      'tag': 'New',
      'description': 'AIO Kit terbaru dari Lost Vape. Desain compact dengan performa maksimal. Kompatibel dengan Boro Tank.\n\nInclude:\n- Centaurus B80 AIO Device\n- UB AIO Pod\n- Centaurus Boro Tank'
    },
    {
      'name': 'TRML T28 Onyx Kit Bundling Foom',
      'price': 'Rp 220.000',
      'originalPrice': 'Rp 300.000',
      'category': 'Device',
      'stock': 10,
      'images': [
        'https://vapeboss.co.id/assets/Product/20251114/TRML-T28-Bundling-Foom-Icy-Honeydew-1__FillWzU0MCwzNDJd.png',
        'https://vapeboss.co.id/assets/Product/20251114/TRML-T28-Bundling-Foom-Icy-Mango-1__FillWzU0MCwzNDJd.png',
      ],
      'tag': 'Promo',
      'description': 'Paket hemat siap ngebul! Pod TRML T28 yang stylish dibundling langsung dengan Liquid Foom 15ml. Rasa dijamin nendang.\n\nPilihan Rasa Liquid:\n- Icy Honeydew\n- Icy Mango'
    },
    {
      'name': 'Wasp Nano X V2 Pod Kit',
      'price': 'Rp 180.000',
      'category': 'Device',
      'stock': 0, // CONTOH STOK HABIS
      'images': [
        'https://vapeboss.co.id/assets/Product/20251029/WASP-NANO-X-2__FillWzU0MCwzNDJd.0-Metallic-Silver.png',
      ],
      'tag': '',
      'description': 'Pod kecil cabe rawit dari Oumier. Menghasilkan flavour yang tebal dengan airflow yang bisa diatur. Baterai awet untuk pemakaian seharian.'
    },
    {
      'name': 'Centaurus E40 Pod Kit',
      'price': 'Rp 350.000',
      'category': 'Device',
      'stock': 8,
      'images': [
        'https://vapeboss.co.id/assets/Product/20241021/Centaurus-E40__FillWzU0MCwzNDJd.jpg',
        'https://vapeboss.co.id/assets/Product/20241021/E40__FillWzM1NSwzNTVd.jpg',
      ],
      'tag': 'Best',
      'description': 'Pod System 40 Watt dengan baterai besar 1400mAh. Desain panel belakang yang artistik dan mewah.\n\nFitur:\n- Max 40W Output\n- Adjustable Airflow\n- Fast Charging Type-C'
    },

    // --- LIQUID ---
    {
      'name': 'Foom Icy Fruity Series 30ml',
      'price': 'Rp 110.000',
      'category': 'Liquid',
      'stock': 50,
      'images': [
        'https://vapeboss.co.id/assets/Product/20241105/foom-icy-pineapple__FillWzU0MCwzNDJd.jpg',
        'https://vapeboss.co.id/assets/Product/20240719/Foom-icy-straw__FillWzU0MCwzNDJd.jpeg',
      ],
      'tag': 'Best',
      'description': 'Liquid Saltnic dingin yang menyegarkan. Tersedia rasa Pineapple dan Strawberry. Cocok untuk pod system.'
    },
    {
      'name': 'NEW FOOM MAX Series',
      'price': 'Rp 115.000',
      'category': 'Liquid',
      'stock': 25,
      'images': [
        'https://vapeboss.co.id/assets/Product/20251029/Foom-Max-Icy-Mango__FillWzU0MCwzNDJd.png',
        'https://vapeboss.co.id/assets/Product/20251029/Foom-Max-Iced-Tea-v2__FillWzU0MCwzNDJd.png',
      ],
      'tag': 'New',
      'description': 'Seri terbaru dari Foom Max. Kapasitas lebih besar, rasa lebih bold. Pilihan tepat untuk daily vaping.'
    },
    {
      'name': 'Happi Krunch Milky Series 60ml',
      'price': 'Rp 145.000',
      'originalPrice': 'Rp 160.000',
      'category': 'Liquid',
      'stock': 12,
      'images': [
        'https://vapeboss.co.id/assets/Product/20250610/HK-Milky-__FillWzM1NSwzNTVd.jpg',
      ],
      'tag': 'Promo',
      'description': 'Liquid Freebase creamy dengan rasa susu sereal yang gurih dan manis pas. Throat hit nendang.'
    },
    {
      'name': 'Friends And Enemies Strawberry',
      'price': 'Rp 150.000',
      'category': 'Liquid',
      'stock': 15,
      'images': [
        'https://vapeboss.co.id/assets/Product/20241029/Friendenemies__FillMaxWzUxMCw2NDBd.jpg',
      ],
      'tag': '',
      'description': 'Kolaborasi Dukun Vape X RAW Brewery. Rasa strawberry yang mainstream tapi bikin nagih. Wajib coba!'
    },
    {
      'name': 'American Winter Salt Series',
      'price': 'Rp 105.000',
      'category': 'Liquid',
      'stock': 20,
      'images': [
        'https://vapeboss.co.id/assets/Product/20250305/American-winter-__FillMaxWzUxMCw2NDBd.jpg',
      ],
      'tag': 'Dingin',
      'description': 'Liquid Saltnic legendaris dari Hero57. Sensasi dingin menthol khas Amerika yang menyegarkan tenggorokan.'
    },
    {
      'name': 'Buaqita Beverages Series',
      'price': 'Rp 100.000',
      'category': 'Liquid',
      'stock': 30,
      'images': [
        'https://vapeboss.co.id/assets/Product/20241223/Buaqita-beverages-__FillMaxWzUxMCw2NDBd.jpg',
      ],
      'tag': '',
      'description': 'Liquid Saltnic rasa minuman segar. Manisnya pas tidak bikin eneg.'
    },
  ];

  int _currentBannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // --- DRAWER ---
      endDrawer: Drawer(
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.menu_open, color: Colors.amber),
                        SizedBox(width: 10),
                        Text("MENU UTAMA", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.grey, height: 1),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  children: [
                    _buildDrawerItem(Icons.home_outlined, "Home", () => Navigator.pop(context)),
                    _buildDrawerItem(Icons.shopping_bag_outlined, "Belanja", () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(allProducts: products)));
                    }),
                    _buildDrawerItem(Icons.newspaper, "News", () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const NewsScreen()));
                    }),
                    _buildDrawerItem(Icons.local_offer_outlined, "Promo Spesial", () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen(categoryName: "Promo", allProducts: products)));
                    }),
                    const Divider(color: Colors.grey, thickness: 0.5),
                    _buildDrawerItem(Icons.storefront, "Lokasi Store", () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LocationScreen()));
                    }),
                    _buildDrawerItem(Icons.info_outline, "Tentang Kami", () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
                    }),
                    _buildDrawerItem(Icons.contact_support_outlined, "Hubungi Admin", () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactScreen()));
                    }),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  border: const Border(top: BorderSide(color: Colors.grey, width: 0.5)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(backgroundColor: Colors.black, child: Icon(Icons.person, color: Colors.white)),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Halo, Rajaku!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            Text("Member Vapstore", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        onPressed: (){},
                        icon: const Icon(Icons.workspace_premium, size: 20),
                        label: const Text("REKOMENDASI SAYA", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Image.network(
          'https://via.placeholder.com/120x40/000000/FFFFFF?text=VAPEBOSS',
          height: 35,
          errorBuilder: (context, error, stackTrace) => const Text("VAPSTORE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(allProducts: products))),
          ),
          Consumer<CartProvider>(
            builder: (context, cart, child) => Badge(
              label: Text(cart.itemCount.toString()),
              isLabelVisible: cart.itemCount > 0,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen())),
              ),
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),

      // ISI HOME
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(height: 180.0, autoPlay: true, enlargeCenterPage: true, aspectRatio: 16/9, viewportFraction: 0.9, onPageChanged: (index, reason) => setState(() => _currentBannerIndex = index)),
              items: imgList.map((item) => Container(margin: const EdgeInsets.symmetric(horizontal: 5.0), child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(10.0)), child: Image.network(item, fit: BoxFit.cover, width: 1000.0, errorBuilder: (ctx, err, stack) => Container(color: Colors.grey[800]))))).toList(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: categories.map((cat) => GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen(categoryName: cat['name'], allProducts: products))), child: Column(children: [Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey[900], shape: BoxShape.circle, border: Border.all(color: Colors.red.withOpacity(0.5))), child: Icon(cat['icon'], color: Colors.white, size: 24)), const SizedBox(height: 8), Text(cat['name'], style: const TextStyle(color: Colors.white70, fontSize: 12))]))).toList(),
              ),
            ),
            const SizedBox(height: 25),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text("Rekomendasi Vapers", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text("Lihat Semua", style: TextStyle(color: Colors.red, fontSize: 12))])),
            const SizedBox(height: 15),
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15), shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.65, crossAxisSpacing: 15, mainAxisSpacing: 15),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                bool hasDiscount = product['originalPrice'] != null;
                bool isOutOfStock = (product['stock'] ?? 0) <= 0;

                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product))),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(12)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                      // --- GAMBAR PRODUK (PERBAIKAN FIT: CONTAIN + BG PUTIH) ---
                      Expanded(
                          child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity, // Pastikan mengisi full
                                    color: Colors.white, // BG Putih agar gambar contain rapi
                                    child: Image.network(
                                      product['images'][0],
                                      fit: BoxFit.contain, // GANTI KE CONTAIN
                                      errorBuilder: (ctx, error, stack) => Container(color: Colors.grey, child: const Icon(Icons.image)),
                                    ),
                                  ),
                                  // Label Stok Habis
                                  if (isOutOfStock)
                                    Container(
                                      color: Colors.black.withOpacity(0.7),
                                      alignment: Alignment.center,
                                      child: const Text("STOK HABIS", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                    ),
                                ],
                              )
                          )
                      ),

                      Padding(padding: const EdgeInsets.all(10.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        if (product['tag'] != '') Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)), child: Text(product['tag'], style: const TextStyle(color: Colors.white, fontSize: 10))),
                        const SizedBox(height: 5),
                        Text(product['name'], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        if (hasDiscount) Text(product['originalPrice'], style: const TextStyle(color: Colors.grey, fontSize: 12, decoration: TextDecoration.lineThrough, decorationColor: Colors.red)),
                        Text(product['price'], style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                      ])),
                    ]),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 22),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 15)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTap,
    );
  }
}