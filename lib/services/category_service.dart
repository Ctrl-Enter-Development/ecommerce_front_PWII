// lib/services/category_service.dart
import '../models/category.dart';
import '../repositories/category_repository.dart';

class CategoryService {
  final CategoryRepository _repository = CategoryRepository();

  Future<List<Category>> getCategories() {
    return _repository.fetchCategories();
  }

  Future<Category> addCategory(Category category) {
    return _repository.createCategory(category);
  }

  Future<Category> updateCategory(Category category) async {
  return await _repository.updateCategory(category);
}

  Future<void> removeCategory(int id) {
    return _repository.deleteCategory(id);
  }
}
