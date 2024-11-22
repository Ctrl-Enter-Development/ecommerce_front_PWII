// lib/repositories/category_repository.dart
import '../models/category.dart';

class CategoryRepository {
  static final List<Category> _categories = []; // Lista interna de categorias
  static int _nextId = 1; // Variável para acompanhar o próximo ID disponível

  // Simula a latência de uma chamada a um backend
  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(
        Duration(milliseconds: 10)); // Simula um atraso de 10 milissegundos
  }

  // Função para buscar todas as categorias
  Future<List<Category>> fetchCategories() async {
    await _simulateNetworkDelay(); // Aguarda o atraso simulado
    return List.from(_categories); // Retorna uma cópia da lista de categorias
  }

  // Função para criar uma nova categoria
  Future<Category> createCategory(Category category) async {
    await _simulateNetworkDelay();
    final newCategory = Category(id: _nextId++, name: category.name);
    _categories.add(newCategory);
    return newCategory;
  }

  // Função para deletar uma categoria
  Future<void> deleteCategory(int id) async {
    await _simulateNetworkDelay(); // Aguarda o atraso simulado
    _categories.removeWhere(
        (category) => category.id == id); // Remove a categoria da lista
  }
}
