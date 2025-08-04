import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/api_client_helper.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductById(String id);
  Future<Product> updateProduct(Product product);
  Future<Product> deleteProduct(String id);
  Future<Product> createProduct(Product product);
}

class ProductRemoteDataSourceImp implements ProductRemoteDataSource {
  final ApiClientHelper apiHelper;

  ProductRemoteDataSourceImp({required this.apiHelper});

  static const String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v3/products';

  @override
  Future<List<Product>> getAllProducts() async {
    final response = await apiHelper.get(baseUrl);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List<dynamic> jsonList = decoded['data'];
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    final response = await apiHelper.get('$baseUrl/$id');

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return ProductModel.fromJson(decoded['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> updateProduct(Product product) async {
    final response = await apiHelper.put(
      '$baseUrl/${product.id}',
      (product as ProductModel).toJson(),
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return ProductModel.fromJson(decoded['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> deleteProduct(String id) async {
    final response = await apiHelper.delete('$baseUrl/$id');

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return ProductModel.fromJson(decoded['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> createProduct(Product product) async {
    final response = await apiHelper.post(
      baseUrl,
      (product as ProductModel).toJson(),
    );

    if (response.statusCode == 201) {
      final decoded = json.decode(response.body);
      return ProductModel.fromJson(decoded['data']);
    } else {
      throw ServerException();
    }
  }
}
