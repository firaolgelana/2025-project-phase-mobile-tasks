import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getLastProducts();
  Future<void> cacheProducts(List<Product> products);
  Future<List<Product>> getCachedProducts();
  Future<void> cacheProduct(ProductModel productToCache);
  Future<Product> getProductById(int id);
  Future<void> clearCache();
}
