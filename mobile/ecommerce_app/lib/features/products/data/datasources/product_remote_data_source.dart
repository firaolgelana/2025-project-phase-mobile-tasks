import '../../domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductById(int id);
  Future<Product> updateProduct(Product product);
  Future<Product> deleteProduct(int id);
  Future<Product> createProduct(Product product);
}