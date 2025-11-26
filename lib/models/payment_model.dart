// lib/models/payment_model.dart
class Payment {
  final String orderId;
  final double amount;
  final String paymentMethod;
  final DateTime paymentDate;

  Payment({
    required this.orderId,
    required this.amount,
    required this.paymentMethod,
    required this.paymentDate,
  });

  // Fungsi untuk mengonversi objek Payment menjadi Map
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'paymentDate': paymentDate.toIso8601String(),
    };
  }

  // Fungsi untuk membuat objek Payment dari JSON
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      orderId: json['orderId'],
      amount: json['amount'],
      paymentMethod: json['paymentMethod'],
      paymentDate: DateTime.parse(json['paymentDate']),
    );
  }
}
