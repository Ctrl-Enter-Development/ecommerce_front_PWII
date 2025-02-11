class ProductQuestion {
  final int id;
  final int productId;
  final int userId;
  final String question;
  final String? answer;
  final int createdAt;
  final int answeredAt;

  ProductQuestion({
    required this.id,
    required this.productId,
    required this.userId,
    required this.question,
    this.answer,
    required this.createdAt,
    required this.answeredAt,
  });

  factory ProductQuestion.fromJson(Map<String, dynamic> json) {
    return ProductQuestion(
      id: json['id'] as int,
      productId: json['productId'] as int,
      userId: json['userId'] as int,
      question: json['question'] as String,
      answer: (json['answer'] as String).isEmpty ? null : json['answer'] as String,
      createdAt: json['createdAt'] as int,
      answeredAt: json['answeredAt'] is int ? json['answeredAt'] as int : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'userId': userId,
      'question': question,
      'answer': answer ?? "",
      'createdAt': createdAt,
      'answeredAt': answeredAt,
    };
  }
}