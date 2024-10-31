import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product}) : super(key: ValueKey(product.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(product.name),
        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            Provider.of<ProductController>(context, listen: false)
                .removeProduct(product.id);
          },
        ),
      ),
    );
  }
}

