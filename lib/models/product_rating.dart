// lib/models/product_rating.dart
class ProductRating {
  final int id;
  final int productId;
  final int userId;
  final double rating;
  final int createdAt;

  ProductRating({
    required this.id,
    required this.productId,
    required this.userId,
    required this.rating,
    required this.createdAt,
  });

  factory ProductRating.fromJson(Map<String, dynamic> json) {
    return ProductRating(
      id: json['id'] as int,
      productId: json['productId'] as int,
      userId: json['userId'] as int,
      rating: (json['rating'] as num).toDouble(),
      createdAt: json['created_at'] as int, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'userId': userId,
      'rating': rating,
      'createdAt': createdAt,
    };
  }
}