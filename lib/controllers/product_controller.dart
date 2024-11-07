//lib/controllers/product_controller.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
class ProductController extends ChangeNotifier {
  final ProductService _service = ProductService();
  List<Product> _products = [];

  List<Product> get products => _products;

  // Função para carregar os produtos
  Future<void> loadProducts() async {
    try {
      _products = await _service.getProducts();
      notifyListeners();
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  // Função para adicionar um novo produto
  Future<void> addProduct(Product product) async {
    try {
      final addedProduct = await _service.addProduct(product);
      _products.add(addedProduct);
      notifyListeners();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  // Função para remover um produto

  Future<void> removeProduct(int id) async {
    try {
      await _service.removeProduct(id);
      _products.removeWhere((product) => product.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
}

