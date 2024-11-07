// lib/repositories/category_repository.dart
import '../models/category.dart';

class CategoryRepository {
  final List<Category> _categories = [];

  Future<List<Category>> fetchCategories() async {
    return List.from(_categories);
  }

  Future<Category> createCategory(Category category) async {
    _categories.add(category);
    return category;
  }

  Future<void> deleteCategory(int id) async {
    _categories.removeWhere((category) => category.id == id);
  }
}
