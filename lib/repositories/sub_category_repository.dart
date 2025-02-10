// lib/repositories/subcategory_repository.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../models/subcategory.dart';

class SubCategoryRepository {
  final String _baseUrl = "https://x8ki-letl-twmt.n7.xano.io/api:tPOO5Nin";

  Future<List<SubCategory>> fetchSubCategories() async {
    final url = Uri.parse('$_baseUrl/sub_category_repository');
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
      return data.map((json) => SubCategory.fromJson(json)).toList();
    }
    throw Exception("Erro ao buscar subcategorias");
  }

  Future<SubCategory> createSubCategory(SubCategory subCategory) async {
    final url = Uri.parse('$_baseUrl/sub_category_repository');
    final token = await GetStorage().read('authToken');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "name": subCategory.name,
        "categoryId": subCategory.categoryId,
        // Caso seja necessário enviar detalhes da categoria, adicione-os.
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return SubCategory.fromJson(data);
    }
    throw Exception("Erro ao criar subcategoria");
  }

  Future<void> deleteSubCategory(int id) async {
    final url = Uri.parse('$_baseUrl/sub_category_repository/$id');
    final token = await GetStorage().read('authToken');
    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao deletar subcategoria");
    }
  }
}