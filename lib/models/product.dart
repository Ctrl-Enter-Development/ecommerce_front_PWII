//lib/models/product.dart
import 'subcategory.dart'; // Importa o modelo de SubCategory

class Product {
  int id;
  String name;
  double price;
  int subCategoryId; // ID da subcategoria associada
  SubCategory
      subCategory; // Objeto SubCategory para acessar detalhes da subcategoria

  // Construtor da classe Product
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.subCategoryId,
    required this.subCategory,
  });

  // Fábrica que cria uma instância de Product a partir de um JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      subCategoryId: json['sub_category_id'],
      subCategory: SubCategory.fromJson(json['sub_category']),
    );
  }

  // Método que converte uma instância de Product para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'sub_category_id': subCategoryId,
      'sub_category': subCategory.toJson(),
    };
  }
}
