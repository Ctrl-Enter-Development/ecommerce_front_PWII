import 'dart:typed_data'; 
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

  Future<Product> updateProduct(Product product, {Uint8List? fileBytes, String? fileName}) async {
  return await _repository.updateProduct(product, fileBytes: fileBytes, fileName: fileName);
  }

  Future<void> removeProduct(int id) {
    return _repository.deleteProduct(id);
  }
}