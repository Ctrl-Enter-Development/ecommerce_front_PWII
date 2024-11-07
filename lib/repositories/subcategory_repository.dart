// lib/repositories/subcategory_repository.dart
import '../models/subcategory.dart';

class SubCategoryRepository {
  final List<SubCategory> _subCategories = [];

  Future<List<SubCategory>> fetchSubCategories() async {
    return List.from(_subCategories);
  }

  Future<SubCategory> createSubCategory(SubCategory subCategory) async {
    _subCategories.add(subCategory);
    return subCategory;
  }

  Future<void> deleteSubCategory(int id) async {
    _subCategories.removeWhere((subCategory) => subCategory.id == id);
  }
}
