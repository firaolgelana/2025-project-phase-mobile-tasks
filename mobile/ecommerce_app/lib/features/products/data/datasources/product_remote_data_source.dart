import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
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
  final http.Client client;

  ProductRemoteDataSourceImp({required this.client});

  static const String _baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v3/products';

  @override
  Future<List<Product>> getAllProducts() async {
    final response = await client.get(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      final List<dynamic> jsonList = jsonMap['data'];
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    final response = await client.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return ProductModel.fromJson(jsonMap['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> updateProduct(Product product) async {
    final response = await client.put(
      Uri.parse('$_baseUrl/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode((product as ProductModel).toJson()),
    );

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return ProductModel.fromJson(jsonMap['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> deleteProduct(String id) async {
    final response = await client.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return ProductModel.fromJson(jsonMap['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> createProduct(Product product) async {
    final response = await client.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode((product as ProductModel).toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return ProductModel.fromJson(jsonMap['data']);
    } else {
      throw ServerException();
    }
  }
}
