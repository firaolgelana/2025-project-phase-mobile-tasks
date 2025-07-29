import 'package:ecommerce_app/features/products/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
   var productModel = const ProductModel(
    id: 1,
    name: 'Test Product',
    description: 'This is a test product',
    price: 49.99,
    imageUrl: 'https://example.com/image.jpg',
  );

  final productJson = {
    'id': 1,
    'name': 'Test Product',
    'description': 'This is a test product',
    'price': 49.99,
    'imageUrl': 'https://example.com/image.jpg',
  };

  test('fromJson should return a valid model', () {
    final result = ProductModel.fromJson(productJson);
    expect(result, equals(productModel));
  });

  test('toJson should return a valid map', () {
    final result = productModel.toJson();
    expect(result, equals(productJson));
  });
}
