import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fungsi untuk mengambil data pengguna dari API
  Future<void> loadUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _users = data.map((userData) => User.fromJson(userData)).toList();
        print('Users loaded: $_users'); // Debugging statement
      } else {
        _errorMessage = 'Gagal memuat data pengguna';
        print('Error: ${response.statusCode}'); // Debugging statement
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: $e';
      print('Exception: $e'); // Debugging statement
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
