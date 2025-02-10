import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);
    final total = cartController.totalPrice;

    return Scaffold(
      appBar: AppBar(
        title: Text("Finalizar Pedido"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Total do Pedido: \$${total.toStringAsFixed(2)}"),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text("Confirmar Pedido"),
              onPressed: () {
                cartController.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Pedido realizado com sucesso!")),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}