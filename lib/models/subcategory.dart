import 'package:ecommerce_front/models/category.dart';

class SubCategory {
  final int id;
  final String name;
  final int categoryId; // ID da categoria à qual a subcategoria pertence
  final Category
      category; // Objeto Category para acessar informações da categoria

  // Construtor da classe SubCategory
  SubCategory({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.category,
  });

  // Fábrica que cria uma instância de SubCategory a partir de um JSON
  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      categoryId: json['category_id'],
      category: Category.fromJson(json['category']),
    );
  }

  // Método que converte uma instância de SubCategory para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category_id': categoryId,
    };
  }
}
