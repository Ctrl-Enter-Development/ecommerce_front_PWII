// lib/screens/product_details_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_front/utils/app_storage.dart';
import 'package:ecommerce_front/models/product.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Future<Product> _futureProduct;

  @override
  void initState() {
    super.initState();
    _futureProduct = fetchProductDetails(widget.productId);
  }

  Future<Product> fetchProductDetails(int id) async {
    final token = AppStorage.instance.token;
    final url = Uri.parse('https://x8ki-letl-twmt.n7.xano.io/api:tPOO5Nin/product_repository/$id');
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception("Erro ao buscar detalhes do produto");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Produto"),
      ),
      body: FutureBuilder<Product>(
        future: _futureProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final product = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  product.image?.url != null && product.image!.url.isNotEmpty
                      ? Image.network(
                          product.image!.url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 300,
                        )
                      : Container(
                          width: double.infinity,
                          height: 300,
                          color: Colors.grey,
                          child: Icon(Icons.image, size: 100),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(product.name,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("\$${product.price.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 20, color: Colors.green)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Subcategoria: ${product.subCategory}", style: TextStyle(fontSize: 16)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Descrição: ${product.description}", style: TextStyle(fontSize: 16)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<CartController>(context, listen: false)
                            .addProductToCart(product, 1);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Produto adicionado ao carrinho")),
                        );
                      },
                      child: Text("Adicionar ao Carrinho"),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}