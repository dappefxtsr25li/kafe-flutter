import 'package:flutter/material.dart';
import '../models/product_model.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Product> _favoriteProducts = [];

  List<Product> get favoriteProducts => List.unmodifiable(_favoriteProducts); // Membuat daftar favorit hanya bisa dibaca

  // Menambahkan atau menghapus produk dari daftar favorit
  void toggleFavorite(Product product) {
    final isFavorited = _favoriteProducts.any((item) => item.id == product.id);
    if (isFavorited) {
      _favoriteProducts.removeWhere((item) => item.id == product.id); // Hapus produk berdasarkan ID
    } else {
      _favoriteProducts.add(product); // Tambahkan produk ke daftar favorit
    }
    notifyListeners(); // Beri tahu UI untuk memperbarui tampilan
  }

  // Cek apakah produk ada dalam daftar favorit
  bool isFavorite(String productId) {
    return _favoriteProducts.any((item) => item.id == productId);
  }

  // Hapus produk dari daftar favorit
  void removeFavorite(Product product) {
    _favoriteProducts.removeWhere((item) => item.id == product.id); // Hapus berdasarkan ID
    notifyListeners();
  }

  // Hapus semua produk dari daftar favorit
  void clearFavorites() {
    _favoriteProducts.clear(); // Hapus semua item
    notifyListeners();
  }
}
