// lib/repositories/login_repository.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class LoginRepository {
  final String _baseUrl = "https://x8ki-letl-twmt.n7.xano.io/api:tPOO5Nin";

  Future<bool> login(String username, String password) async {
    try {
      final url = Uri.parse('$_baseUrl/auth/login');
      final body = jsonEncode({
        "userName": username,
        "password": password,
      });

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['authToken'] != null) {
          await GetStorage().write('authToken', data['authToken']);
          return true;
        }
      } else {
        print("Erro no login: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      print("Erro ao realizar login: $e");
    }
    return false;
  }
}