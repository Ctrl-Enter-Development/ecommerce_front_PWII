// lib/services/subcategory_service.dart
import '../models/subcategory.dart';
import '../repositories/subcategory_repository.dart';

class SubCategoryService {
  final SubCategoryRepository _repository = SubCategoryRepository();

  Future<List<SubCategory>> getSubCategories() {
    return _repository.fetchSubCategories();
  }

  Future<SubCategory> addSubCategory(SubCategory subCategory) {
    return _repository.createSubCategory(subCategory);
  }

  Future<SubCategory> updateSubCategory(SubCategory subCategory) async {
  return await _repository.updateSubCategory(subCategory);
  }

  Future<void> removeSubCategory(int id) {
    return _repository.deleteSubCategory(id);
  }
}
