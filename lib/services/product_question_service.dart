import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce_front/utils/app_storage.dart';
import '../models/product_question.dart';

class ProductQuestionService {
  final String _baseUrl = "https://x8ki-letl-twmt.n7.xano.io/api:tPOO5Nin/product_questions";

  Future<List<ProductQuestion>> getQuestions() async {
    final url = Uri.parse(_baseUrl);
    final token = AppStorage.instance.token;
    final response = await http.get(url, headers: {
      "accept": "application/json",
      "authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ProductQuestion.fromJson(json)).toList();
    }
    throw Exception("Erro ao buscar perguntas: ${response.statusCode}");
  }

  Future<ProductQuestion> postQuestion(ProductQuestion question) async {
    final url = Uri.parse(_baseUrl);
    final token = AppStorage.instance.token;
    final response = await http.post(url,
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
      },
      body: jsonEncode(question.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ProductQuestion.fromJson(jsonDecode(response.body));
    }
    throw Exception("Erro ao postar a pergunta: ${response.statusCode}");
  }

    Future<ProductQuestion> answerQuestion(ProductQuestion question, String answer) async {
    final url = Uri.parse("$_baseUrl/${question.id}");
    final token = AppStorage.instance.token;
    final body = jsonEncode({
        'productId': question.productId,
        'userId': question.userId,  
        'answer': answer,
        'answeredAt': DateTime.now().millisecondsSinceEpoch,
    });
    final response = await http.patch(url,
        headers: {
        "content-type": "application/json",
        "authorization": "Bearer $token",
        },
        body: body,
    );
    if (response.statusCode == 200) {
        return ProductQuestion.fromJson(jsonDecode(response.body));
    }
    throw Exception("Erro ao atualizar a resposta: ${response.statusCode}");
    }
}