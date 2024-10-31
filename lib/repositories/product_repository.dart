import '../models/product.dart';

class ProductRepository {
  final List<Product> _products = [];

  // Busca todos os produtos
  Future<List<Product>> fetchProducts() async {
    return List.from(_products); // Retorna uma cópia da lista de produtos
  }

  // Cria e adiciona um novo produto à lista
  Future<Product> createProduct(Product product) async {
    _products.add(product);
    return product; // Retorna o produto criado
  }

  // Remove um produto da lista pelo ID
  Future<void> deleteProduct(int id) async {
    _products.removeWhere((product) => product.id == id);
  }
}