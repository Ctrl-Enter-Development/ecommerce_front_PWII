import 'package:ecommerce_front/models/category.dart';

class SubCategory {
  final int id;
  final String name;
  final int categoryId;
  final String category; // Agora é uma String

  SubCategory({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.category,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      categoryId: json['categoryId'] as int,
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'category': category,
    };
  }
}