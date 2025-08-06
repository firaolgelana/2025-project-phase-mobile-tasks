import 'dart:convert';

import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/core/utils/api_client_helper.dart';
import 'package:ecommerce_app/features/products/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/products/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'product_remote_data_source_test.mocks.dart';

@GenerateMocks([ApiClientHelper])
void main() {
  late ProductRemoteDataSourceImp dataSource;
  late MockApiClientHelper mockApiHelper;

  setUp(() {
    mockApiHelper = MockApiClientHelper();
    dataSource = ProductRemoteDataSourceImp(apiHelper: mockApiHelper);
  });

  const tId = '1';
  final singleJson = json.decode(fixture('product.json'))['data'];
  final productListJson = json.decode(fixture('products.json'))['data'];

  final tProductModel = ProductModel.fromJson(singleJson);
  final expectedList = (productListJson as List)
    .map((item) => ProductModel.fromJson(item))
    .toList();


  group('getAllProducts', () {
    test('should return list of products when status is 200', () async {
      when(mockApiHelper.get(any)).thenAnswer(
      (_) async => http.Response(json.encode({'data': productListJson}), 200),

      );

      final result = await dataSource.getAllProducts();

      expect(result, equals(expectedList));
      verify(mockApiHelper.get('https://g5-flutter-learning-path-be-tvum.onrender.com/api/v1/products')).called(1);
    });

    test('should throw ServerException when status is not 200', () async {
      when(mockApiHelper.get(any))
          .thenAnswer((_) async => http.Response('Error', 404));

      expect(() => dataSource.getAllProducts(), throwsA(isA<ServerException>()));
    });
  });

  group('getProductById', () {
    test('should return Product when status is 200', () async {
      when(mockApiHelper.get(any)).thenAnswer(
          (_) async => http.Response(fixture('product.json'), 200));

      final result = await dataSource.getProductById(tId);

      expect(result, equals(tProductModel));
      verify(mockApiHelper.get('https://g5-flutter-learning-path-be-tvum.onrender.com/api/v1/products/$tId')).called(1);
    });

    test('should throw ServerException when status is not 200', () async {
      when(mockApiHelper.get(any))
          .thenAnswer((_) async => http.Response('Error', 404));

      expect(() => dataSource.getProductById(tId), throwsA(isA<ServerException>()));
    });
  });

  group('updateProduct', () {
    test('should return updated Product when status is 200', () async {
      when(mockApiHelper.put(any, any)).thenAnswer(
        (_) async => http.Response(fixture('product.json'), 200),
      );

      final result = await dataSource.updateProduct(tProductModel);

      expect(result, equals(tProductModel));
      verify(mockApiHelper.put(
        'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v1/products/${tProductModel.id}',
        tProductModel.toJson(),
      )).called(1);
    });

    test('should throw ServerException when status is not 200', () async {
      when(mockApiHelper.put(any, any)).thenAnswer(
        (_) async => http.Response('Error', 400),
      );

      expect(() => dataSource.updateProduct(tProductModel), throwsA(isA<ServerException>()));
    });
  });

  group('deleteProduct', () {
    test('should return deleted Product when status is 200', () async {
      when(mockApiHelper.delete(any)).thenAnswer(
        (_) async => http.Response(fixture('product.json'), 200),
      );

      final result = await dataSource.deleteProduct(tId);

      expect(result, equals(tProductModel));
      verify(mockApiHelper.delete('https://g5-flutter-learning-path-be-tvum.onrender.com/api/v1/products/$tId')).called(1);
    });

    test('should throw ServerException when status is not 200', () async {
      when(mockApiHelper.delete(any))
          .thenAnswer((_) async => http.Response('Error', 404));

      expect(() => dataSource.deleteProduct(tId), throwsA(isA<ServerException>()));
    });
  });

  group('createProduct', () {
    test('should return created Product when status is 201', () async {
      when(mockApiHelper.post(any, any)).thenAnswer(
        (_) async => http.Response(fixture('product.json'), 201),
      );

      final result = await dataSource.createProduct(tProductModel);

      expect(result, equals(tProductModel));
      verify(mockApiHelper.post(
        'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v1/products',
        tProductModel.toJson(),
      )).called(1);
    });

    test('should throw ServerException when status is not 201', () async {
      when(mockApiHelper.post(any, any)).thenAnswer(
        (_) async => http.Response('Error', 400),
      );

      expect(() => dataSource.createProduct(tProductModel), throwsA(isA<ServerException>()));
    });
  });
}
