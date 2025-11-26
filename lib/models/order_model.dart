import 'product_model.dart';

class Order {
  final List<Product> products;
  final String customerName;
  final String status;
  final DateTime orderDate;

  Order({
    required this.products,
    required this.customerName,
    required this.status,
    required this.orderDate,
  });

  double get totalPrice {
    return products.fold(0.0, (sum, product) => sum + product.price); // Use double for price
  }

  // Fungsi untuk mengonversi objek Order menjadi Map (misalnya untuk menyimpan ke database atau API)
  Map<String, dynamic> toJson() {
    return {
      'customerName': customerName,
      'status': status,
      'orderDate': orderDate.toIso8601String(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }

  // Fungsi untuk membuat objek Order dari JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    var list = json['products'] as List;
    List<Product> productList = list.map((product) => Product.fromJson(product)).toList();

    return Order(
      products: productList,
      customerName: json['customerName'],
      status: json['status'],
      orderDate: DateTime.parse(json['orderDate']),
    );
  }
}
