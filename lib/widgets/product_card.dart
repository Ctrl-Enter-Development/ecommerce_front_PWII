// lib/widgets/product_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../controllers/product_controller.dart';
import '../controllers/auth_controller.dart';
import '../screens/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product}) : super(key: ValueKey(product.id));

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    bool isAdmin = authController.user?.role == "Admin";

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(productId: product.id),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.image?.url != null && product.image!.url.isNotEmpty
                ? Image.network(
                    product.image!.url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 120,
                  )
                : Container(
                    width: double.infinity,
                    height: 120,
                    color: Colors.grey,
                    child: Icon(Icons.image, size: 60),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product.name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("\$${product.price.toStringAsFixed(2)}"),
            ),
            if (isAdmin)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Provider.of<ProductController>(context, listen: false)
                        .removeProduct(product.id);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}