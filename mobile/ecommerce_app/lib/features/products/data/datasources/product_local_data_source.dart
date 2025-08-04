import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<Product> products);
  Future<List<Product>> getCachedProducts();
  Future<void> cacheProduct(ProductModel productToCache);
  Future<Product> getProductById(String id);
  Future<void> clearCache();
}

class ProductLocalDataSourceImp implements ProductLocalDataSource {
  final cachedProducts = 'CACHED_PRODUCTS';
  final SharedPreferences sharedPreferences;
  ProductLocalDataSourceImp({required this.sharedPreferences});
  @override
  Future<void> cacheProduct(ProductModel productToCache) async {
    final cachedList = sharedPreferences.getStringList(cachedProducts) ?? [];

    final updatedList = [
      ...cachedList.where((jsonStr) {
        final product = ProductModel.fromJson(json.decode(jsonStr));
        return product.id != productToCache.id; 
      }),
      json.encode(productToCache.toJson()),
    ];

    final success = await sharedPreferences.setStringList(cachedProducts, updatedList);
    if (!success) {
      throw CacheException();
    }
    return;
  }


  @override
  Future<void> cacheProducts(List<Product> products) async {
    final jsonList = products
        .map((product) => json.encode((product as ProductModel).toJson()))
        .toList();

    final success = await sharedPreferences.setStringList(cachedProducts, jsonList);
    if (!success) throw CacheException();
    return;
  }


  @override
  Future<void> clearCache() async {
    final success = await sharedPreferences.remove(cachedProducts);
    if (!success) throw CacheException();
    return;
  }


  @override
  Future<List<Product>> getCachedProducts() {
    final jsonList = sharedPreferences.getStringList(cachedProducts);
    if (jsonList == null) {
      throw CacheException();
    }
    final products = jsonList
        .map((jsonStr) => ProductModel.fromJson(json.decode(jsonStr)))
        .toList();
    return Future.value(products);
  }

  @override
  Future<Product> getProductById(String id) {
    final jsonList = sharedPreferences.getStringList(cachedProducts);
    if (jsonList == null) {
      throw CacheException();
    }

    final products = jsonList
        .map((jsonStr) => ProductModel.fromJson(json.decode(jsonStr)))
        .toList();

    try {
      final product = products.firstWhere((p) => p.id == id);
      return Future.value(product);
    } catch (_) {
      throw CacheException(); 
    }
  }

}
