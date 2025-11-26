import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mendapatkan data pengguna yang dipilih
    final User user = ModalRoute.of(context)?.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(title: Text('Detail Pengguna')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Role: ${user.role}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
