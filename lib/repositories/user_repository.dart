// lib/repositories/user_repository.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../models/user.dart';

class UserRepository {
  final String _baseUrl = "https://x8ki-letl-twmt.n7.xano.io/api:tPOO5Nin";

  Future<List<User>> fetchUsers() async {
    final url = Uri.parse('$_baseUrl/user_repository');
    final token = await GetStorage().read('authToken');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    }
    throw Exception("Erro ao buscar usuários");
  }

  Future<User> createUser(User user) async {
    final url = Uri.parse('$_baseUrl/user_repository');
    final token = await GetStorage().read('authToken');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "userName": user.userName,
        "password": user.password,
        "roleId": user.roleId,
        // Se necessário, envie o nome do perfil:
        "role": user.role,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    }
    throw Exception("Erro ao criar usuário");
  }

  Future<void> deleteUser(int id) async {
    final url = Uri.parse('$_baseUrl/user_repository/$id');
    final token = await GetStorage().read('authToken');
    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao deletar usuário");
    }
  }
}