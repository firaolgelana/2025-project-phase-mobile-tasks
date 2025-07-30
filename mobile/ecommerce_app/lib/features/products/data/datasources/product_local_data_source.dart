import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<ProductModel> getLastProduct();
  Future<void> cacheProduct(ProductModel productToCache);
}
