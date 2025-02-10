import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecommerce_front/utils/app_storage.dart';
import '../models/category.dart';

class CategoryRepository {
  final String _baseUrl = "https://x8ki-letl-twmt.n7.xano.io/api:tPOO5Nin";

  Future<List<Category>> fetchCategories() async {
    final url = Uri.parse('$_baseUrl/category_repository');
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
      return data.map((json) => Category.fromJson(json)).toList();
    }
    throw Exception("Erro ao buscar categorias");
  }

  Future<Category> createCategory(Category category) async {
    final url = Uri.parse('$_baseUrl/category_repository');
    final token = AppStorage.instance.token;
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "name": category.name,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Category.fromJson(data);
    }
    throw Exception("Erro ao criar categoria");
  }

  Future<void> deleteCategory(int id) async {
    final url = Uri.parse('$_baseUrl/category_repository/$id');
    final token = AppStorage.instance.token;
    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao deletar categoria");
    }
  }
}