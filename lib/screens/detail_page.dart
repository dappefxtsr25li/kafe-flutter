import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk mengatur status bar
import '../models/product_model.dart';

class DetailPage extends StatefulWidget {
  final Product product;

  DetailPage({required this.product});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double calculateAverageRating() {
    if (widget.product.reviews.isEmpty) return 0.0;

    double sum = widget.product.reviews.fold(0.0, (previousValue, review) => previousValue + review.rating);
    return sum / widget.product.reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    // Mengatur status bar agar tampak sesuai kebutuhan
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Status bar transparan
      statusBarIconBrightness: Brightness.dark, // Warna ikon status bar
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Rp ${widget.product.price.toString()}',
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Text(
              widget.product.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Center(
              child: widget.product.imageUrl != null && widget.product.imageUrl!.isNotEmpty
                  ? (widget.product.imageUrl!.startsWith('http')
                      ? Image.network(widget.product.imageUrl!, height: 200)
                      : Image.asset(widget.product.imageUrl!, height: 200))
                  : Icon(Icons.error, size: 100, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rating: ${calculateAverageRating().toStringAsFixed(1)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.star, color: Colors.orange, size: 24),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Ulasan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: widget.product.reviews.length,
                itemBuilder: (context, index) {
                  final review = widget.product.reviews[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(review.username, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(review.comment),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (i) => Icon(
                          i < review.rating ? Icons.star : Icons.star_border,
                          color: Colors.orange,
                        )),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
