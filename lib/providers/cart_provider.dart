import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  // Mendapatkan semua item di keranjang
  Map<String, CartItem> get items => _items;

  // Jumlah total item di keranjang
  int get itemCount => _items.length;

  // Total harga semua item di keranjang
  double get totalAmount {
    return _items.values.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  // Menambahkan item ke keranjang
  void addToCart(CartItem cartItem) {
    if (_items.containsKey(cartItem.id)) {
      // Jika item sudah ada, tambahkan kuantitasnya
      _items[cartItem.id]!.quantity += cartItem.quantity;
    } else {
      // Jika item belum ada, tambahkan ke keranjang
      _items[cartItem.id] = cartItem;
    }
    notifyListeners();
  }

  // Menghapus item dari keranjang
  void removeFromCart(String id) {
    _items.remove(id);
    notifyListeners();
  }

  // Mengupdate kuantitas item dalam keranjang
  void updateQuantity(String id, int newQuantity) {
    if (_items.containsKey(id)) {
      if (newQuantity > 0) {
        _items[id]!.quantity = newQuantity;
      } else {
        // Jika kuantitas 0, hapus item
        _items.remove(id);
      }
      notifyListeners();
    }
  }

  // Menghapus semua item dari keranjang (digunakan untuk proses checkout)
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Menampilkan daftar item (opsional, untuk men-debug atau keperluan lain)
  void printCartItems() {
    _items.forEach((key, item) {
      print('${item.name} - ${item.quantity} - ${item.price}');
    });
  }
}
