// ==== lib/controllers/product_controller.dart ====
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../services/subcategory_service.dart'; 

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

  Future<void> loadProductsBySubcategory(int subcategoryId) async {
    try {
      List<Product> allProducts = await _service.getProducts();
      _products = allProducts.where((p) => p.subCategoryId == subcategoryId).toList();
      notifyListeners();
    } catch (e) {
      print('Error loading products by subcategory: $e');
    }
  }

  Future<void> loadProductsByCategory(int categoryId) async {
    try {
      List<Product> allProducts = await _service.getProducts();
      final subCategoryService = SubCategoryService();
      final subCategories = await subCategoryService.getSubCategories();
      final List<int> subcatIds = subCategories
          .where((sub) => sub.categoryId == categoryId)
          .map((sub) => sub.id)
          .toList();
      _products = allProducts.where((p) => subcatIds.contains(p.subCategoryId)).toList();
      notifyListeners();
    } catch (e) {
      print('Error loading products by category: $e');
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

  Future<void> updateProduct(Product product, {Uint8List? fileBytes, String? fileName}) async {
    try {
      final updatedProduct = await _service.updateProduct(product, fileBytes: fileBytes, fileName: fileName);
      final index = _products.indexWhere((p) => p.id == updatedProduct.id);
      if (index != -1) {
        _products[index] = updatedProduct;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating product: $e');
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