import '../models/product.dart';
import '../repositories/product_repository.dart';

class ProductService {
  final ProductRepository _repository = ProductRepository();

  Future<List<Product>> getProducts() {
    return _repository.fetchProducts();
  }

  Future<Product> addProduct(Product product) {
    return _repository.createProduct(product);
  }

  Future<void> removeProduct(int id) {
    return _repository.deleteProduct(id);
  }
}

