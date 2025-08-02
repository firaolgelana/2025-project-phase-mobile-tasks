import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
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
  final http.Client client;

  ProductRemoteDataSourceImp({required this.client});

  @override
  Future<List<Product>> getAllProducts() async {
    final response = await client.get(
      Uri.parse('https://api.example.com/products'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> getProductById(int id) async {
    final response = await client.get(Uri.parse('https://api.example.com/products/$id'));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> updateProduct(Product product) async {
    final response = await client.put(
      Uri.parse('https://api.example.com/products/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode((product as ProductModel).toJson()),
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> deleteProduct(int id) async {
    final response = await client.delete(Uri.parse('https://api.example.com/products/$id'));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> createProduct(Product product) async {
    final response = await client.post(
      Uri.parse('https://api.example.com/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode((product as ProductModel).toJson()),
    );
    if (response.statusCode == 201) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}