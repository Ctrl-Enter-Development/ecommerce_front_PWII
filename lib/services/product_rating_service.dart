// lib/services/product_rating_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce_front/utils/app_storage.dart';
import '../models/product_rating.dart';

class ProductRatingService {
  final String _baseUrl = "https://x8ki-letl-twmt.n7.xano.io/api:tPOO5Nin/product_ratings";

  Future<List<ProductRating>> getRatings(int productId) async {
    final url = Uri.parse("$_baseUrl?productId=$productId");
    final token = AppStorage.instance.token;
    final response = await http.get(url, headers: {
      "accept": "application/json",
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ProductRating.fromJson(json)).toList();
    }
    throw Exception("Erro ao buscar avaliações: ${response.statusCode}");
  }

  Future<ProductRating> postRating(ProductRating rating) async {
    final url = Uri.parse(_baseUrl);
    final token = AppStorage.instance.token;
    final response = await http.post(url,
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(rating.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ProductRating.fromJson(jsonDecode(response.body));
    }
    throw Exception("Erro ao postar a avaliação: ${response.statusCode}");
  }
}