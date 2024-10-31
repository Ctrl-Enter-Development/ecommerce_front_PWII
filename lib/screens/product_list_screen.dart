import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Para gerenciar o estado com o controller
import '../controllers/product_controller.dart';
import '../widgets/product_card.dart';
import 'add_product_popup.dart'; // A tela de adicionar produto

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Carregar os produtos quando a tela for construída
    final controller = Provider.of<ProductController>(context, listen: false);
    controller.loadProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implementar a funcionalidade de pesquisa
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Abrir a tela de adicionar produto em um popup
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddProductPopup();
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.update),
            onPressed: () {
              // Implementar a funcionalidade de pesquisa
            },
          ),
        ],
      ),
      body: Consumer<ProductController>(
        builder: (context, controller, child) {
          if (controller.products.isEmpty) {
            return const Text("nenhum produto cadastrado");
          }
          return ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: controller.products[index]);
            },
          );
        },
      ),
    );
  }
}

