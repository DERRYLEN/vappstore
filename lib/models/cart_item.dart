class CartItem {
  final String id;
  final String name;
  final int price;
  final int quantity;
  final String image;
  bool isSelected; // Status Centang

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    this.isSelected = true, // Default: Langsung dicentang saat masuk
  });
}