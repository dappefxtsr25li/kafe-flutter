import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import 'package:flutter/services.dart'; // Pastikan import ini ada jika kamu mengatur status bar

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  String _searchQuery = '';
  String _selectedCategory = 'Semua';

  final List<String> _categories = ['Semua', 'Minuman', 'Kudapan', 'Makanan'];

  int _selectedIndex = 0;  // Untuk melacak halaman yang dipilih pada BottomNavigationBar

  @override
  void initState() {
    super.initState();
    _loadProducts();
    // Mengatur status bar jika perlu
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Mengubah warna status bar menjadi transparan
      statusBarIconBrightness: Brightness.dark, // Menyesuaikan warna ikon di status bar
    ));
  }

  Future<void> _loadProducts() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load products. Please try again.')),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.pushNamed(context, '/favorites'); // Favorit
    } else if (index == 2) {
      Navigator.pushNamed(context, '/cart'); // Keranjang
    } else {
      Navigator.pushNamed(context, '/home'); // Home
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> products = [
      Product(
        id: '1',
        name: 'Espresso',
        price: 20000.0,
        description: 'Kopi ekstrak kuat tanpa campuran.',
        imageUrl: 'assets/images/espresso.jpg',
        category: 'Minuman',
        isFavorite: false,
        reviews: [],
      ),
      Product(
        id: '2',
        name: 'Latte',
        price: 25000.0,
        description: 'Espresso dengan susu creamy.',
        imageUrl: 'assets/images/latte.jpg',
        category: 'Minuman',
        isFavorite: false,
        reviews: [],
      ),
      Product(
        id: '3',
        name: 'Cappuccino',
        price: 30000.0,
        description: 'Espresso, susu, dan busa tebal.',
        imageUrl: 'assets/images/cappuccino.jpg',
        category: 'Minuman',
        isFavorite: false,
        reviews: [],
      ),
      Product(
        id: '4',
        name: 'Americano',
        price: 22000.0,
        description: 'Espresso dengan air panas.',
        imageUrl: 'assets/images/americano.jpg',
        category: 'Minuman',
        isFavorite: false,
        reviews: [],
      ),
      Product(
        id: '5',
        name: 'Iced Coffee',
        price: 20000.0,
        description: 'Kopi panas dingin dengan es.',
        imageUrl: 'assets/images/icedcoffee.jpeg',
        category: 'Minuman',
        isFavorite: false,
        reviews: [],
      ),
      Product(
        id: '6',
        name: 'Macchiato',
        price: 20000.0,
        description: 'Espresso dengan sedikit busa susu.',
        imageUrl: 'assets/images/macchiato.jpeg',
        category: 'Minuman',
        isFavorite: false,
        reviews: [],
      ),
      Product(
        id: '7',
        name: 'Kue Cubir',
        price: 15000.0,
        description: 'Kue lezat dan manis.',
        imageUrl: 'assets/images/kuecubir.jpeg',
        category: 'Kudapan',
        isFavorite: false,
        reviews: [],
      ),
      Product(
        id: '8',
        name: 'Nasi Goreng',
        price: 30000.0,
        description: 'Nasi goreng daging spesial dengan telur.',
        imageUrl: 'assets/images/nasigoreng.jpeg',
        category: 'Makanan',
        isFavorite: false,
        reviews: [],
      ),
    ];

    final filteredProducts = products.where((product) {
      final searchLower = _searchQuery.toLowerCase();
      return product.name.toLowerCase().contains(searchLower) &&
          (_selectedCategory == 'Semua' || product.category == _selectedCategory);
    }).toList();

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Kafe Kita'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Text(
              'Isi perut yuk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari menu yang kamu mau?',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedCategory == category
                            ? Colors.orange
                            : Colors.grey[300],
                      ),
                      child: Text(category),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredProducts.isEmpty
                    ? Center(
                        child: Text(
                          'Menu tidak ditemukan!',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          final isFavorited = favoritesProvider.isFavorite(product.id);

                          return Card(
                            margin: EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () {
                                if (product != null) {
                                  Navigator.pushNamed(
                                    context,
                                    '/product-detail',
                                    arguments: product,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Produk tidak valid!')),
                                  );
                                }
                              },
                              title: Text(product.name),
                              subtitle: Text('Rp ${product.price}'),
                              leading: Image.asset(
                                product.imageUrl ?? '',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      isFavorited ? Icons.favorite : Icons.favorite_border,
                                      color: isFavorited ? Colors.red : Colors.grey,
                                    ),
                                    onPressed: () {
                                      favoritesProvider.toggleFavorite(product);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.shopping_cart),
                                    onPressed: () {
                                      cartProvider.addToCart(
                                        CartItem(
                                          id: product.id,
                                          name: product.name,
                                          price: product.price,
                                          quantity: 1,
                                          imageUrl: product.imageUrl,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
        ],
      ),
    );
  }
}
