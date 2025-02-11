// lib/controllers/product_controller.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductController extends ChangeNotifier {
  final ProductService _service = ProductService();
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> loadProducts() async {
    try {
      _products = await _service.getProducts();
      notifyListeners();
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  // Método para filtrar os produtos pela subcategoria (filtragem no cliente)
  Future<void> loadProductsBySubcategory(int subcategoryId) async {
    try {
      // Busca todos os produtos
      List<Product> allProducts = await _service.getProducts();
      // Filtra os produtos cujo subCategoryId seja igual ao informado
      _products = allProducts.where((p) => p.subCategoryId == subcategoryId).toList();
      notifyListeners();
    } catch (e) {
      print('Error loading products by subcategory: $e');
    }
  }

  Future<void> addProductWithFile(Product product, {Uint8List? fileBytes, String? fileName}) async {
    try {
      final addedProduct = await _service.createProduct(product, fileBytes: fileBytes, fileName: fileName);
      _products.add(addedProduct);
      notifyListeners();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

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