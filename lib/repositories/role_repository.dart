import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecommerce_front/utils/app_storage.dart';
import '../models/role.dart';

class RoleRepository {
  final String _baseUrl = "https://x8ki-letl-twmt.n7.xano.io/api:tPOO5Nin";

  Future<List<Role>> fetchRoles() async {
    final url = Uri.parse('$_baseUrl/role_repository');
    final token = AppStorage.instance.token;
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Role.fromJson(json)).toList();
    }
    throw Exception("Erro ao buscar perfis");
  }

  Future<Role> createRole(Role role) async {
    final url = Uri.parse('$_baseUrl/role_repository');
    final token = AppStorage.instance.token;
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "name": role.name,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Role.fromJson(data);
    }
    throw Exception("Erro ao criar perfil");
  }

  Future<void> deleteRole(int id) async {
    final url = Uri.parse('$_baseUrl/role_repository/$id');
    final token = AppStorage.instance.token;
    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao deletar perfil");
    }
  }
}