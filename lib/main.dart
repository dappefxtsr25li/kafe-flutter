import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Untuk State Management
import 'screens/home_page.dart';
import 'screens/detail_page.dart';
import 'screens/cart_page.dart'; // Halaman Keranjang
import 'screens/home_selection_page.dart'; // Halaman Seleksi Awal
import 'screens/favorites_page.dart'; // Halaman Favorit
import 'models/product_model.dart';
import 'providers/cart_provider.dart'; // Penyedia untuk keranjang
import 'providers/favorites_provider.dart'; // Penyedia untuk favorit
import 'package:flutter/services.dart'; // Untuk mengatur status bar

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(), // Integrasi CartProvider untuk keranjang
        ),
        ChangeNotifierProvider(
          create: (context) => FavoritesProvider(), // Integrasi FavoritesProvider
        ),
      ],
      child: MaterialApp(
        title: 'Aplikasi Kafe',
        theme: ThemeData(
          // Warna dan tema utama aplikasi
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.brown[800],
            secondary: Colors.orange[400],
            background: Colors.white,
            surface: Colors.grey[100],
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onBackground: Colors.black,
            onSurface: Colors.black,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.brown[800],
            foregroundColor: Colors.white,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          textTheme: TextTheme(
            headlineLarge: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            bodyLarge: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown[800], // Warna tombol utama
              foregroundColor: Colors.white, // Warna teks pada tombol
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.orange[400], // Warna teks tombol
            ),
          ),
          scaffoldBackgroundColor: Colors.white, // Latar belakang aplikasi
        ),
        debugShowCheckedModeBanner: false, // Menghilangkan debug banner
        initialRoute: '/', // Halaman pertama aplikasi
        routes: {
          '/': (context) => HomeSelectionPage(), // Halaman pemilihan awal
          '/home': (context) => HomePage(), // Halaman utama (daftar produk)
          '/cart': (context) => CartPage(), // Halaman keranjang belanja
          '/favorites': (context) => FavoritesPage(), // Halaman favorit
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/product-detail') {
            // Periksa apakah settings.arguments adalah Product
            if (settings.arguments is Product) {
              final product = settings.arguments as Product;
              return MaterialPageRoute(
                builder: (context) => DetailPage(product: product),
              );
            } else {
              // Jika tidak valid, arahkan ke halaman error atau kembali ke home
              return MaterialPageRoute(
                builder: (context) => HomePage(), // Bisa diganti dengan halaman error
              );
            }
          }
          return null; // Kembalikan null jika rute tidak ditemukan
        },
        builder: (context, child) {
          // Pengaturan status bar global
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent, // Status bar transparan
            statusBarIconBrightness: Brightness.dark, // Warna ikon status bar
          ));
          return child!;
        },
      ),
    );
  }
}
