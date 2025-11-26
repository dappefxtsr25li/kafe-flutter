import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    // Mengambil data dari provider dan memuat pengguna
    userProvider.loadUsers();

    if (userProvider.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Daftar Pengguna')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (userProvider.errorMessage.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Daftar Pengguna')),
        body: Center(child: Text(userProvider.errorMessage)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Daftar Pengguna')),
      body: ListView.builder(
        itemCount: userProvider.users.length,
        itemBuilder: (context, index) {
          final User user = userProvider.users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/userDetail',
                arguments: user,
              );
            },
          );
        },
      ),
    );
  }
}
