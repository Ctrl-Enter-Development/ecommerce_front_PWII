import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/app_storage.dart';
import '../models/user.dart';

class AuthService {
  final String _baseUrl = "https://x8ki-letl-twmt.n7.xano.io/api:tPOO5Nin";

  Future<User> getMe() async {
    final token = AppStorage.instance.token;
    if (token == null) {
      throw Exception("Token não encontrado");
    }

    final url = Uri.parse('$_baseUrl/auth/me');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        return User.fromJson(data);
      } catch (e) {
        throw Exception("Erro ao decodificar a resposta: $e");
      }
    } else if (response.statusCode == 401) {
      throw Exception("Token inválido");
    } else {
      throw Exception("Erro ao buscar dados do usuário: ${response.statusCode}");
    }
  }
}