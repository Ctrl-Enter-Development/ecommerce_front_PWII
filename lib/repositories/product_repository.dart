// lib/repositories/product_repository.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../models/product.dart';

class ProductRepository {
  final String _baseUrl = "https://x8ki-letl-twmt.n7.xano.io/api:tPOO5Nin";

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('$_baseUrl/product_repository');
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
      return data.map((json) => Product.fromJson(json)).toList();
    }
    throw Exception("Erro ao buscar produtos");
  }

  Future<Product> createProduct(Product product) async {
    final url = Uri.parse('$_baseUrl/product_repository');
    final token = await GetStorage().read('authToken');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "name": product.name,
        "price": product.price,
        "subCategoryId": product.subCategoryId,
        // Se a API necessitar do campo "subCategory" ou outros detalhes, adicione-os aqui.
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Product.fromJson(data);
    }
    throw Exception("Erro ao criar produto");
  }

  Future<void> deleteProduct(int id) async {
    final url = Uri.parse('$_baseUrl/product_repository/$id');
    final token = await GetStorage().read('authToken');
    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao deletar produto");
    }
  }
}