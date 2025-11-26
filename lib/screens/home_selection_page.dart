import 'package:flutter/material.dart';
import 'home_page.dart'; // Import HomePage
import 'user_detail_page.dart'; // Import UserDetailPage

class HomeSelectionPage extends StatelessWidget {
  const HomeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pilih Halaman')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6F4C3E), // Dark brown
              Color(0xFFBFA6A1), // Light brown
              Color(0xFFE8D8C0), // Cream
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Panah di belakang tombol
              Positioned(
                top: 100,
                left: 50,
                child: CustomPaint(
                  size: Size(100, 100),
                  painter: ArrowPainter(),
                ),
              ),
              Positioned(
                top: 100,
                right: 50,
                child: CustomPaint(
                  size: Size(100, 100),
                  painter: ArrowPainter(),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Selamat Datang',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()), // Navigasi ke halaman menu
                      );
                    },
                    child: Text('Menu'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 122, 85, 30), // Button color
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserDetailPage()), // Navigasi ke halaman profil
                      );
                    },
                    child: Text('Profil'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 129, 88, 26), // Button color
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Gambar panah
    Path path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(size.width / 2, size.height / 2);
    path.lineTo(size.width / 4, size.height / 2);
    path.lineTo(size.width / 4, size.height / 4);
    path.lineTo(0, size.height / 4);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
