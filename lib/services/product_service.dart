import 'dart:typed_data'; // Import necessário para Uint8List
import '../models/product.dart';
import '../repositories/product_repository.dart';

class ProductService {
  final ProductRepository _repository = ProductRepository();

  Future<List<Product>> getProducts() {
    return _repository.fetchProducts();
  }

  Future<Product> createProduct(Product product, {Uint8List? fileBytes, String? fileName}) async {
    return await _repository.createProduct(product, fileBytes: fileBytes, fileName: fileName);
  }

  Future<void> removeProduct(int id) {
    return _repository.deleteProduct(id);
  }
}