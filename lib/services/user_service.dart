import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserService {
  final String apiUrl = "https://api.example.com/users"; // Ganti dengan URL API yang sesuai

  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((userJson) => User.fromJson(userJson)).toList();
      } else {
        throw Exception("Gagal memuat data pengguna");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan: $e");
    }
  }
}
