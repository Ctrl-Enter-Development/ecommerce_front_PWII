// lib/repositories/product_repository.dart
import 'dart:convert';
import 'dart:typed_data'; // Import necessário para Uint8List
import 'package:http/http.dart' as http;
import 'package:ecommerce_front/utils/app_storage.dart';
import '../models/product.dart';

class ProductRepository {
  final String _baseUrl = "https://x8ki-letl-twmt.n7.xano.io/api:tPOO5Nin";

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('$_baseUrl/product_repository');
    final token = AppStorage.instance.token;
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    }
    throw Exception("Erro ao buscar produtos");
  }

Future<Product> createProduct(Product product, {Uint8List? fileBytes, String? fileName}) async {
  final uri = Uri.parse('$_baseUrl/product_repository'); 
  final token = AppStorage.instance.token;
  final request = http.MultipartRequest("POST", uri);
  request.headers['Authorization'] = "Bearer $token";

  request.fields['name'] = product.name;
  request.fields['price'] = product.price.toString();
  request.fields['subCategoryId'] = product.subCategoryId.toString();
  request.fields['subCategory'] = product.subCategory;
  request.fields['description'] = product.description;

  if (fileBytes != null && fileName != null) {
    request.files.add(
      http.MultipartFile.fromBytes(
        'url', 
        fileBytes,
        filename: fileName,
      ),
    );
  } else {
 
    request.fields['url'] = "";
  }

  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return Product.fromJson(data);
  }
  throw Exception("Erro ao criar produto");
}


  Future<void> deleteProduct(int id) async {
    final url = Uri.parse('$_baseUrl/product_repository/$id');
    final token = AppStorage.instance.token;
    final response = await http.delete(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });
    if (response.statusCode != 200) {
      throw Exception("Erro ao deletar produto");
    }
  }
}