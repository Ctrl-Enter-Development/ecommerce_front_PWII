// lib/models/product.dart
import 'subcategory.dart';

class ProductImage {
  final String access;
  final String path;
  final String name;
  final String type;
  final int size;
  final String mime;
  final Map<String, dynamic>? meta;
  final String url; 

  ProductImage({
    required this.access,
    required this.path,
    required this.name,
    required this.type,
    required this.size,
    required this.mime,
    required this.meta,
    required this.url,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      access: json['access'] as String,
      path: json['path'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      size: json['size'] as int,
      mime: json['mime'] as String,
      meta: json['meta'] as Map<String, dynamic>?,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access': access,
      'path': path,
      'name': name,
      'type': type,
      'size': size,
      'mime': mime,
      'meta': meta,
      'url': url,
    };
  }
}

class Product {
  int id;
  String name;
  double price;
  int subCategoryId;
  String subCategory;
  String description;
  ProductImage? image; 

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.subCategoryId,
    required this.subCategory,
    required this.description,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      subCategoryId: json['subCategoryId'] as int,
      subCategory: json['subCategory'] as String,
      description: json['description'] as String? ?? "",
      image: json['image'] != null ? ProductImage.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'subCategoryId': subCategoryId,
      'subCategory': subCategory,
      'description': description,
      'url': image?.url ?? "",
    };
  }
}