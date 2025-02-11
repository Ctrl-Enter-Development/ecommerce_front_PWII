// lib/widgets/product_rating_widget.dart
import 'package:flutter/material.dart';
import '../models/product_rating.dart';
import '../services/product_rating_service.dart';

class ProductRatingWidget extends StatefulWidget {
  final int productId;
  final int currentUserId; 

  const ProductRatingWidget({
    Key? key,
    required this.productId,
    required this.currentUserId,
  }) : super(key: key);

  @override
  _ProductRatingWidgetState createState() => _ProductRatingWidgetState();
}

class _ProductRatingWidgetState extends State<ProductRatingWidget> {
  final ProductRatingService _ratingService = ProductRatingService();
  late Future<List<ProductRating>> _futureRatings;
  final TextEditingController _ratingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRatings();
  }

    void _loadRatings() {
    _futureRatings = _ratingService.getRatings(widget.productId).then((allRatings) {
        return allRatings.where((rating) => rating.productId == widget.productId).toList();
    });
    setState(() {});
    }

  double _calculateAverage(List<ProductRating> ratings) {
    if (ratings.isEmpty) return 0.0;
    double total = ratings.fold(0.0, (prev, rating) => prev + rating.rating);
    return total / ratings.length;
  }

  Future<void> _submitRating() async {
    final value = double.tryParse(_ratingController.text);
    if (value == null || value < 0 || value > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Informe uma nota válida entre 0 e 5.")),
      );
      return;
    }
    final now = DateTime.now().millisecondsSinceEpoch;
    final newRating = ProductRating(
      id: 0, 
      productId: widget.productId,
      userId: widget.currentUserId,
      rating: value,
      createdAt: now,
    );
    await _ratingService.postRating(newRating);
    _ratingController.clear();
    _loadRatings();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductRating>>(
      future: _futureRatings,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(child: Text("Erro ao carregar avaliações."));
        final ratings = snapshot.data ?? [];
        final average = _calculateAverage(ratings);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Média de Avaliação: ${average.toStringAsFixed(1)} / 5",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _ratingController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Sua nota (0 a 5)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _submitRating,
              child: Text("Avaliar Produto"),
            ),
          ],
        );
      },
    );
  }
}