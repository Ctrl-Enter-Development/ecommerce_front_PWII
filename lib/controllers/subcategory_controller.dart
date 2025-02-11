import 'package:flutter/material.dart';
import '../models/subcategory.dart';
import '../services/subcategory_service.dart';

class SubCategoryController extends ChangeNotifier {
  final SubCategoryService _service = SubCategoryService();
  List<SubCategory> _subCategories = [];

  List<SubCategory> get subCategories => _subCategories;

  Future<void> loadSubCategories() async {
    try {
      _subCategories = await _service.getSubCategories();
      notifyListeners();
    } catch (e) {
      print('Error loading subcategories: $e');
    }
  }

  /// Método para uso com FutureBuilder
  Future<List<SubCategory>> fetchSubCategories() async {
    await loadSubCategories();
    return subCategories;
  }

  Future<void> addSubCategory(SubCategory subCategory) async {
    try {
      final addedSubCategory = await _service.addSubCategory(subCategory);
      _subCategories.add(addedSubCategory);
      notifyListeners();
    } catch (e) {
      print('Error adding subcategory: $e');
    }
  }

  Future<void> removeSubCategory(int id) async {
    try {
      await _service.removeSubCategory(id);
      _subCategories.removeWhere((subCategory) => subCategory.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting subcategory: $e');
    }
  }
}