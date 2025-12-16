import 'package:flutter/material.dart';
import '../models/book.dart';

class ProductProvider with ChangeNotifier {
  // DATABASE PRODUK (UPDATE: STOK PER VARIAN)
  final List<Product> _allProducts = [

    // =========================================
    // KATEGORI: DEVICE
    // =========================================
    Product(
      id: '1',
      name: 'Hotcig R99 Uncommon Mod Kit Authentic',
      price: 'Rp 450.000', originalPrice: 'Rp 600.000',
      description: 'Hotcig R99 uncommon Mod Kit Authentic.\nSpesification:\nWatt: 10.0W - 99.0W\nInclude: Mod, Atomizer RDA, Coil & Kapas',
      variants: [
        ProductVariant(name: 'A-Bliss', stock: 3),
        ProductVariant(name: 'Limea', stock: 2),
      ],
      imageColor: 'pink', category: 'device',
      imageUrls: ['https://static.jakmall.id/2025/09/images/products/ae3c2b/detail/hotcig-r99-mod-kit-99w-authentic-by-vapeboss.jpeg'],
    ),
    Product(
      id: 'DEV-02', name: 'New Open System Oxva Nexlim Go', price: 'Rp 250.000', originalPrice: '',
      description: 'OXVA NEXLIM GO POD KIT 100% Authentic.\nBuilt-in 1800mAh Battery.',
      variants: [
        ProductVariant(name: 'Silky Black', stock: 5),
        ProductVariant(name: 'Silky Coffee', stock: 5),
        ProductVariant(name: 'Sahara Brown', stock: 4),
        ProductVariant(name: 'Rose Pink', stock: 3),
        ProductVariant(name: 'Space Gray', stock: 3),
      ],
      imageColor: 'black', category: 'device',
      imageUrls: ['https://th.bing.com/th/id/R.41b1b5850d75db8be809217e35505725?rik=QunZpvlH6scEgg&riu=http%3a%2f%2fwww.oxva.id%2fcdn%2fshop%2farticles%2fNeXLIM_ALL_COLOR_6_17223d2f-ca31-434b-b90a-7305b2cdedb9.jpg%3fv%3d1758193846&ehk=D%2bY3BP08DtXvPj%2fDe6hiZdInD85jtbaTLQqCunr2pyo%3d&risl=&pid=ImgRaw&r=0'],
    ),
    Product(
      id: 'DEV-03', name: 'TRML T28 Onyx - Thermal T28 Kit', price: 'Rp 200.000', originalPrice: '',
      description: 'TRML T28 Pod kit 100% Authentic.\nBundling foom 15ML.',
      variants: [
        ProductVariant(name: 'Midnight Blue', stock: 6),
        ProductVariant(name: 'Onyx Black', stock: 7),
        ProductVariant(name: 'Rich Brown', stock: 6),
        ProductVariant(name: 'Soft Pink', stock: 6),
      ],
      imageColor: 'blue', category: 'device',
      imageUrls: ['https://static.jakmall.id/2025/07/images/products/5b9da9/detail/trml-t28-pod-kit-bundling-package.jpeg'],
    ),
    Product(
      id: 'DEV-04', name: 'Centaurus B80S Aio Kit Authentic', price: 'Rp 450.000', originalPrice: '',
      description: 'Centaurus B80S Aio Kit Authentic by Lost Vape.\nSingle 18650 battery.',
      variants: [
        ProductVariant(name: 'Default', stock: 10),
      ],
      imageColor: 'grey', category: 'device',
      imageUrls: ['https://i0.wp.com/vapehan.com/wp-content/uploads/2025/01/asdasdasdasdasdad.jpg?fit=1920%2C1920&ssl=1'],
    ),
    Product(
      id: 'DEV-05', name: 'Centaurus E40 40W 1400mAh Pod Kit', price: 'Rp 295.000', originalPrice: '',
      description: 'Centaurus E40 40W 1400mAh Pod Kit by Lost Vape.',
      variants: [
        ProductVariant(name: 'Glistening Blue', stock: 3),
        ProductVariant(name: 'Sakura Cyclone', stock: 3),
        ProductVariant(name: 'Violet Cyclone', stock: 3),
        ProductVariant(name: 'Carbon Fiber', stock: 3),
        ProductVariant(name: 'E40 Bingo', stock: 2),
        ProductVariant(name: 'E40 Spirit', stock: 1),
      ],
      imageColor: 'purple', category: 'device',
      imageUrls: ['https://image.vapesourcing.com/images/202406/lost-vape-centaurus-e40-2.jpg'],
    ),

    // =========================================
    // KATEGORI: LIQUID FREEBASE
    // =========================================
    Product(
      id: 'LB-01', name: 'Ketan Jinak Freebase', price: 'Rp 120.000', originalPrice: '',
      description: 'Ketan Jinak 100% Authentic by Koko Sarang Vapers.',
      variants: [
        ProductVariant(name: '3mg', stock: 10),
        ProductVariant(name: '6mg', stock: 10),
        ProductVariant(name: '9mg', stock: 10),
      ],
      imageColor: 'red', category: 'liquid', subCategory: 'Freebase',
      imageUrls: ['https://vapeboss.co.id/assets/Product/20241030/Ketan-jinak-v2__FillWzM1NSwzNTVd.jpg'],
    ),
    Product(
      id: 'LB-02', name: 'Candyman Sour Strawberry', price: 'Rp 140.000', originalPrice: '',
      description: 'Candyman Strawberry 100% Authentic by FVS.',
      variants: [
        ProductVariant(name: '3mg', stock: 8),
        ProductVariant(name: '6mg', stock: 7),
      ],
      imageColor: 'red', category: 'liquid', subCategory: 'Freebase',
      imageUrls: ['https://www.vapeboss.co.id/assets/Product/20241129/Candyman__FillWzM1NSwzNTVd.jpg'],
    ),
    Product(
      id: 'LB-03', name: 'Emaky Bananalicious', price: 'Rp 150.000', originalPrice: '',
      description: 'Bananalicious 100% Authentic by Emkay Brewer.',
      variants: [
        ProductVariant(name: '3mg', stock: 9),
        ProductVariant(name: '6mg', stock: 9),
      ],
      imageColor: 'yellow', category: 'liquid', subCategory: 'Freebase',
      imageUrls: ['https://vapeboss.co.id/assets/Product/20241029/Banana-Liciousjpg-v2__FillWzM1NSwzNTVd.jpg'],
    ),
    Product(
      id: 'LB-04', name: 'Stadz Caramel Popcorn', price: 'Rp 163.300', originalPrice: '',
      description: 'Stadz Caramel Popcorn 60ml.',
      variants: [
        ProductVariant(name: '3mg', stock: 5),
        ProductVariant(name: '6mg', stock: 5),
      ],
      imageColor: 'brown', category: 'liquid', subCategory: 'Freebase',
      imageUrls: ['https://vapeboss.co.id/assets/Product/20241104/Stadz__FillWzM1NSwzNTVd.jpg'],
    ),
    Product(
      id: 'LB-05', name: 'Blackcurrant Jinak Freebase', price: 'Rp 120.000', originalPrice: '',
      description: 'Blackcurrant Jinak 100% Authentic by Koko Sarang.',
      variants: [
        ProductVariant(name: '3mg', stock: 3),
        ProductVariant(name: '6mg', stock: 3),
        ProductVariant(name: '9mg', stock: 4),
      ],
      imageColor: 'purple', category: 'liquid', subCategory: 'Freebase',
      imageUrls: ['https://pix.toco.id/resize/w:700,h:700,fit:cover,f:webp,q:85/toco/img/image-1750736403671.png?s=4f1392f083fef5e4b6746517b6a33e14bca48418a40b06797cb5579735f5f603'],
    ),

    // =========================================
    // KATEGORI: LIQUID SALT
    // =========================================
    Product(
      id: 'LS-01', name: 'Icelands Watermelon Salt Nic', price: 'Rp 100.000', originalPrice: '',
      description: 'Icelands Watermelon Salt Nic 100% Authentic.',
      variants: [
        ProductVariant(name: '30mg', stock: 25),
      ],
      imageColor: 'green', category: 'liquid', subCategory: 'Salt',
      imageUrls: ['https://www.vapeboss.co.id/assets/Product/20231115/Icelands-Salt-v3__FillWzM1NSwzNTVd.jpg'],
    ),
    Product(
      id: 'LS-02', name: 'Una Salt Nic Strawberry', price: 'Rp 100.000', originalPrice: '',
      description: 'Una Salt Nic Series 100% Authentic by IDJ.',
      variants: [
        ProductVariant(name: '12mg', stock: 15),
        ProductVariant(name: '25mg', stock: 15),
      ],
      imageColor: 'pink', category: 'liquid', subCategory: 'Salt',
      imageUrls: ['https://vapeboss.co.id/assets/Product/20241026/Una-Salt__FillWzM1NSwzNTVd.jpg'],
    ),
    Product(
      id: 'LS-03', name: 'Minus Two Brain Freeze', price: 'Rp 120.000', originalPrice: '',
      description: 'Minus Two Barin Freeze Hawaiian Blend Salt Nic.',
      variants: [
        ProductVariant(name: '30mg', stock: 15),
      ],
      imageColor: 'blue', category: 'liquid', subCategory: 'Salt',
      imageUrls: ['https://pix.toco.id/resize/w:700,h:700,fit:cover,f:webp,q:85/toco/img/image-1750733568864.png?s=f8845fc891e39f96938ee2519258f3a30af4b785d4001a66c7a903ad9e89ff7b'],
    ),
    Product(
      id: 'LS-04', name: 'Bequ Watermelon Salt Nic', price: 'Rp 100.000', originalPrice: '',
      description: 'Bequ Watermelon Salt Nic 100% Authentic by Poda E-Liquid.',
      variants: [
        ProductVariant(name: '30mg', stock: 10),
      ],
      imageColor: 'green', category: 'liquid', subCategory: 'Salt',
      imageUrls: ['https://i0.wp.com/vapehan.com/wp-content/uploads/2023/11/bequ-salt-watermelon.jpg?fit=1080%2C1080&ssl=1'],
    ),

    // =========================================
    // KATEGORI: ACCESSORIES
    // =========================================
    Product(
      id: 'AC-01', name: 'Holy Fiber Vape Cotton', price: 'Rp 40.000', originalPrice: '',
      description: 'HOLY FIBER USA COTTON PREMIUM WICKING MATERIAL.',
      variants: [
        ProductVariant(name: 'Pack', stock: 50),
      ],
      imageColor: 'white', category: 'accs',
      imageUrls: ['https://i0.wp.com/vapehan.com/wp-content/uploads/2023/05/1760876_e26b7494-2d99-4392-b9da-eb1c0cdf9fee_1280_1280.jpg?fit=900%2C900&ssl=1'],
    ),
    Product(
      id: 'AC-02', name: 'Cotton Bacon V2 Prime', price: 'Rp 55.000', originalPrice: '',
      description: 'Cotton Bacon Prime by Wick N Vape 100% AUTHENTIC.',
      variants: [
        ProductVariant(name: 'Pack', stock: 60),
      ],
      imageColor: 'white', category: 'accs',
      imageUrls: ['https://i0.wp.com/vaporesia.com/wp-content/uploads/2019/11/Cotton-Bacon-V2-Prime-Vape-Cotton.jpg?fit=750%2C750&ssl=1'],
    ),
    Product(
      id: 'AR-01', name: 'Stalk RDA 22MM Single Coil', price: 'Rp 270.000', originalPrice: '',
      description: 'Stalk RDA 22mm 100% Authentic by ROV.',
      variants: [
        ProductVariant(name: 'Silver', stock: 5),
        ProductVariant(name: 'Black', stock: 5),
        ProductVariant(name: 'Gunmetal', stock: 5),
      ],
      imageColor: 'grey', category: 'accs',
      imageUrls: ['https://vapeboss.co.id/assets/Product/20250310/RDA-Stalk-__FillWzM1NSwzNTVd.jpg'],
    ),
    Product(
      id: 'AR-02', name: 'Dead Rabbit Solo RDA', price: 'Rp 280.000', originalPrice: '',
      description: 'Dead Rabbit Solo RDA 100% Authentic by Hellvape.',
      variants: [
        ProductVariant(name: 'Gold', stock: 3),
        ProductVariant(name: 'Black', stock: 3),
        ProductVariant(name: 'Gunmetal', stock: 3),
        ProductVariant(name: 'Pink', stock: 3),
      ],
      imageColor: 'gold', category: 'accs',
      imageUrls: ['https://www.alivape.com/cdn/shop/files/Hellvape-Dead-Rabbit-Solo-RDA.jpg?v=1732718272'],
    ),
  ];

  List<Product> _displayProducts = [];

  ProductProvider() {
    _displayProducts = _allProducts;
  }

  List<Product> get products => _displayProducts;

  // --- LOGIC PENCARIAN & FILTER ---
  void search(String keyword) {
    if (keyword.isEmpty) {
      _displayProducts = _allProducts;
    } else {
      _displayProducts = _allProducts
          .where((p) => p.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void filterByCategory(String category) {
    if (category == 'all') {
      _displayProducts = _allProducts;
    } else if (category == 'promo') {
      _displayProducts = _allProducts.where((p) => p.originalPrice.isNotEmpty).toList();
    } else {
      _displayProducts = _allProducts
          .where((p) => p.category.toLowerCase() == category.toLowerCase())
          .toList();
    }
    notifyListeners();
  }

  void filterBySubCategory(String category, String subCategory) {
    _displayProducts = _allProducts
        .where((p) =>
    p.category.toLowerCase() == category.toLowerCase() &&
        p.subCategory?.toLowerCase() == subCategory.toLowerCase())
        .toList();
    notifyListeners();
  }

  // --- FUNGSI UPDATE STOK (SUPPORTS VARIAN) ---
  void reduceStock(String productId, String variantName, int quantity) {
    // 1. Cari Produk
    final index = _allProducts.indexWhere((prod) => prod.id == productId);

    if (index != -1) {
      // 2. Cari Varian di dalam Produk tersebut
      final product = _allProducts[index];
      final variantIndex = product.variants.indexWhere((v) => v.name == variantName);

      if (variantIndex != -1) {
        // 3. Kurangi Stok Varian Spesifik
        if (product.variants[variantIndex].stock >= quantity) {
          product.variants[variantIndex].stock -= quantity;
          notifyListeners();
        }
      }
    }
  }
}