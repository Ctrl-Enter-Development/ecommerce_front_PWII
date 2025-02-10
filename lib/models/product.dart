//lib/models/product.dart
import 'subcategory.dart'; // Importa o modelo de SubCategory

class Product {
  int id;
  String name;
  double price;
  int subCategoryId;
  String subCategory; // Agora é uma String

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.subCategoryId,
    required this.subCategory,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      subCategoryId: json['subCategoryId'] as int,
      subCategory: json['subCategory'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'subCategoryId': subCategoryId,
      'subCategory': subCategory,
    };
  }
}