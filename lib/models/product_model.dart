class Product {
  final String id; // ID unik untuk setiap produk
  final String name;
  final double price; // Tipe diubah ke double untuk operasi aritmatika
  final String description;
  final String? imageUrl; // URL gambar opsional
  final String? assetsImages; // Gambar lokal opsional
  final String category; // Kategori produk
  bool isFavorite; // Menambahkan properti isFavorite
  final List<Review> reviews; // Menambahkan properti reviews yang berisi daftar ulasan

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.imageUrl,
    this.assetsImages,
    required this.category, // Kategori produk
    this.isFavorite = false, // Properti isFavorite default-nya false
    required this.reviews, // Menambahkan reviews pada konstruktor
  });

  // Factory method untuk membuat objek dari JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    var reviewList = json['reviews'] as List?; // Menangani data ulasan dalam JSON

    List<Review> reviews = [];
    if (reviewList != null) {
      reviews = reviewList.map((reviewJson) => Review.fromJson(reviewJson)).toList();
    }

    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown Product',
      price: (json['price'] is String)
          ? double.tryParse(json['price']) ?? 0.0
          : json['price']?.toDouble() ?? 0.0,
      description: json['description'] ?? 'No description available',
      imageUrl: json['imageUrl']?.toString(),
      assetsImages: json['assetsImages']?.toString(),
      category: json['category'] ?? 'Uncategorized',
      isFavorite: json['isFavorite'] ?? false,
      reviews: reviews, // Menambahkan reviews yang terambil dari JSON
    );
  }

  // Method untuk mengubah objek ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'assetsImages': assetsImages,
      'category': category,
      'isFavorite': isFavorite,
      'reviews': reviews.map((review) => review.toJson()).toList(), // Menambahkan ulasan ke JSON
    };
  }
}

// Kelas Review untuk representasi ulasan produk
class Review {
  final String username;
  final String comment;
  final int rating;

  Review({
    required this.username,
    required this.comment,
    required this.rating,
  });

  // Factory method untuk membuat objek Review dari JSON
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      username: json['username'] ?? 'Anonymous',
      comment: json['comment'] ?? 'No comment',
      rating: json['rating'] ?? 0,
    );
  }

  // Method untuk mengubah objek Review ke JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'comment': comment,
      'rating': rating,
    };
  }
}
