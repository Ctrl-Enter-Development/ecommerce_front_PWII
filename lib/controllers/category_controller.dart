// lib/controllers/category_controller.dart
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/category_service.dart';

class CategoryController extends ChangeNotifier {
  final CategoryService _service = CategoryService();
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  Future<void> loadCategories() async {
    try {
      _categories = await _service.getCategories();
      notifyListeners();
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  Future<void> addCategory(Category category) async {
    try {
      final addedCategory = await _service.addCategory(category);
      _categories.add(addedCategory);
      notifyListeners();
    } catch (e) {
      print('Error adding category: $e');
    }
  }

  Future<void> updateCategory(Category category) async {
  try {
    final updatedCategory = await _service.updateCategory(category);
    final index = _categories.indexWhere((c) => c.id == updatedCategory.id);
    if (index != -1) {
      _categories[index] = updatedCategory;
      notifyListeners();
    }
  } catch (e) {
    print('Error updating category: $e');
  }
}

  Future<void> removeCategory(int id) async {
    try {
      await _service.removeCategory(id);
      _categories.removeWhere((category) => category.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting category: $e');
    }
  }
}
