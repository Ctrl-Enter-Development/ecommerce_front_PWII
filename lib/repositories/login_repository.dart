//lib\repositories\login_repository.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class LoginRepository {
  final String _baseUrl = "https://x8ki-letl-twmt.n7.xano.io/api:tPOO5Nin/auth/login";
  final _storage = GetStorage(); // Instância do GetStorage

  Future<bool> login(String username, String password) async {
    try {
      // Cria o corpo da requisição
      final body = jsonEncode({
        "userName": username,
        "password": password,
      });

      // Faz a requisição POST
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      // Verifica o status da resposta
      if (response.statusCode == 200) {
        // Decodifica o JSON
        final data = jsonDecode(response.body);

        // Armazena o token no GetStorage
        if (data['authToken'] != null) {
          await _storage.write('authToken', data['authToken']);
          return true; // Login bem-sucedido
        }
      } else {
        print("Erro: ${response.statusCode}, ${response.body}");
      }
    } catch (e) {
      print("Erro ao realizar login: $e");
    }

    return false; // Login falhou
  }
}
