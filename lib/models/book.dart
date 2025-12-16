// CLASS BARU: Untuk menyimpan varian + stoknya
class ProductVariant {
  final String name;
  int stock;

  ProductVariant({required this.name, required this.stock});
}

class Product {
  final String id;
  final String name;
  final String price;
  final String originalPrice;
  final String description;

  // UPDATE: Variants sekarang berisi List of ProductVariant
  final List<ProductVariant> variants;

  final String imageColor;
  final String category;
  final String? subCategory;
  final List<String> imageUrls;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.description,
    required this.variants,
    // Stock global dihapus, kita hitung otomatis dari total varian
    required this.imageColor,
    required this.category,
    required this.imageUrls,
    this.subCategory,
  });

  // HELPER: Menghitung total stok dari semua varian untuk tampilan di katalog
  int get totalStock {
    if (variants.isEmpty) return 0;
    return variants.fold(0, (sum, item) => sum + item.stock);
  }
}