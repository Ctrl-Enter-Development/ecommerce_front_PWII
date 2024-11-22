//lib/repositories/product_repository.dart
import 'package:ecommerce_front/models/product.dart';

class ProductRepository {
  final List<Product> _products = [];
  int _nextId = 1; // Variável para acompanhar o próximo ID disponível

  // Simula a latência de uma chamada a um backend
  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(
        Duration(milliseconds: 10)); // Simula um atraso de 10 milisegundos
  }

  // Busca todos os produtos
  Future<List<Product>> fetchProducts() async {
    return List.from(_products); // Retorna uma cópia da lista de produtos
  }

  // Função para criar um novo produto
  Future<Product> createProduct(Product product) async {
    await _simulateNetworkDelay(); // Aguarda o atraso simulado
    product.id = _nextId++; // Atribui o próximo ID e incrementa a variável
    _products.add(product);

    // Retorna o produto com a subcategoria associada
    return Product(
      id: product.id,
      name: product.name,
      price: product.price,
      subCategoryId: product.subCategoryId,
      subCategory: product.subCategory,
    );
  }

  // Remove um produto da lista pelo ID
  Future<void> deleteProduct(int id) async {
    await _simulateNetworkDelay(); // Aguarda o atraso simulado
    _products.removeWhere((product) => product.id == id);
  }
}