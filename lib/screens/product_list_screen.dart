// lib/screens/product_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';
import '../controllers/auth_controller.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import 'add_product_popup.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productController =
        Provider.of<ProductController>(context, listen: false);
    productController.loadProducts();

    final authController = Provider.of<AuthController>(context);
    final userRole = authController.user?.role ?? "Client"; 

    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos Disponíveis"),
      ),
      body: Consumer<ProductController>(
        builder: (context, controller, child) {
          if (controller.products.isEmpty) {
            return Center(child: Text("Nenhum produto cadastrado"));
          }
          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.75,
            ),
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return ProductCard(product: product);
            },
          );
        },
      ),
      floatingActionButton: userRole == "Client"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: Icon(Icons.shopping_cart),
              backgroundColor: Colors.green,
            )
          : FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AddProductPopup(),
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),
    );
  }
}