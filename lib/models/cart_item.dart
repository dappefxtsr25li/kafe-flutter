class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity; // Bisa berubah sesuai jumlah pesanan
  final String? imageUrl;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1, // Default 1
    this.imageUrl,
  });
}
