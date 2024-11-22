// lib/repositories/sub_category_repository.dart
import '../models/subcategory.dart';

class SubCategoryRepository {
  final List<SubCategory> _subCategories = [];
  int _nextId = 1; // Variável para acompanhar o próximo ID disponível

  // Simula a latência de uma chamada a um backend
  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(
        Duration(milliseconds: 10)); // Simula um atraso de 10 milisegundos
  }

  // Busca todas as subcategorias, incluindo suas categorias
  Future<List<SubCategory>> fetchSubCategories() async {
    return List.from(
        _subCategories); // Retorna uma cópia da lista de subcategorias
  }

  // Função para criar uma nova subcategoria
  Future<SubCategory> createSubCategory(SubCategory subCategory) async {
    await _simulateNetworkDelay(); // Aguarda o atraso simulado
    subCategory.id = _nextId++; // Atribui o próximo ID e incrementa a variável
    _subCategories.add(subCategory);

    // Retorna a subcategoria com a categoria associada
    return SubCategory(
      id: subCategory.id,
      name: subCategory.name,
      categoryId: subCategory.categoryId,
      category: subCategory.category,
    );
  }

  // Remove uma subcategoria da lista pelo ID
  Future<void> deleteSubCategory(int id) async {
    await _simulateNetworkDelay(); // Aguarda o atraso simulado
    _subCategories.removeWhere((subCategory) => subCategory.id == id);
  }
}