import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/api_client_helper.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductById(int id);
  Future<Product> updateProduct(Product product);
  Future<Product> deleteProduct(int id);
  Future<Product> createProduct(Product product);
}

class ProductRemoteDataSourceImp implements ProductRemoteDataSource {
  final ApiClientHelper apiHelper;

  ProductRemoteDataSourceImp({required this.apiHelper});

  @override
  Future<List<Product>> getAllProducts() async {
    final response = await apiHelper.get('https://api.example.com/products');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> getProductById(int id) async {
    final response = await apiHelper.get('https://api.example.com/products/$id');
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

@override
Future<Product> updateProduct(Product product) async {
  final response = await apiHelper.put(
    'https://api.example.com/products/${product.id}',
    (product as ProductModel).toJson(), 
  );

  if (response.statusCode == 200) {
    return ProductModel.fromJson(json.decode(response.body));
  } else {
    throw ServerException();
  }
}


  @override
  Future<Product> deleteProduct(int id) async {
    final response = await apiHelper.delete('https://api.example.com/products/$id');
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> createProduct(Product product) async {
    final response = await apiHelper.post(
      'https://api.example.com/products',
      (product as ProductModel).toJson(),
    );
    if (response.statusCode == 201) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}