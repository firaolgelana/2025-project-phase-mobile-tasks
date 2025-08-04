
import 'dart:convert';

import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/products/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/products/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'product_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main(){
  late ProductRemoteDataSourceImp dataSource;
  late MockClient mockHttpClient;
  setUp(() {
    mockHttpClient = MockClient();
    dataSource = ProductRemoteDataSourceImp(client: mockHttpClient);
  });
    const tId = '1';
    final singleJson = json.decode(fixture('product.json'))['data'];
    final productListJson = json.decode(fixture('products.json'))['data'];

    final tProductModel = ProductModel.fromJson(singleJson);
    final expectedList = (productListJson as List)
      .map((item) => ProductModel.fromJson(item))
      .toList();
    group('getAllProducts', () {
    test(
        'should perform a GET request to the correct URL with application/json header',
        () async {
      // Arrange
      when(mockHttpClient.get(
        Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v3/products'),
        headers: anyNamed('headers'),
      )).thenAnswer(
        (_) async => http.Response(json.encode({'data': productListJson}), 200),
      );

      // Act
      final result = await dataSource.getAllProducts();

      // Assert
      verify(mockHttpClient.get(
        Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v3/products'),
        headers: {'Content-Type': 'application/json'},
      )).called(1);

      expect(result, equals(expectedList));
    });

    test('should throw ServerException when response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Error', 404));

      // Act & Assert
      expect(() => dataSource.getAllProducts(),
          throwsA(isA<ServerException>()));
    });
  });

  group('getProductById', () {
    test('should return Product when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(
        Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v3/products/$tId'),
      )).thenAnswer((_) async => http.Response(fixture('product.json'), 200));

      // act
      final result = await dataSource.getProductById(tId);

      // assert
      expect(result, equals(tProductModel));
    });

    test('should throw ServerException when the response code is not 200', () async {
      when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response('Error', 404));

      expect(() => dataSource.getProductById(tId), throwsA(isA<ServerException>()));
    });
  });

  group('updateProduct', () {
    test('should return updated Product when response code is 200', () async {
      when(mockHttpClient.put(
        Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v3/products/${tProductModel.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tProductModel.toJson()),
      )).thenAnswer((_) async => http.Response(fixture('product.json'), 200));

      final result = await dataSource.updateProduct(tProductModel);

      expect(result, equals(tProductModel));
    });

    test('should throw ServerException when the response code is not 200', () async {
      when(mockHttpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Error', 400));

      expect(() => dataSource.updateProduct(tProductModel), throwsA(isA<ServerException>()));
    });
  });

  group('deleteProduct', () {
    test('should return deleted Product when response code is 200', () async {
      when(mockHttpClient.delete(
        Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v3/products/$tId'),
      )).thenAnswer((_) async => http.Response(fixture('product.json'), 200));

      final result = await dataSource.deleteProduct(tId);

      expect(result, equals(tProductModel));
    });

    test('should throw ServerException when the response code is not 200', () async {
      when(mockHttpClient.delete(any)).thenAnswer((_) async => http.Response('Error', 404));

      expect(() => dataSource.deleteProduct(tId), throwsA(isA<ServerException>()));
    });
  });

  group('createProduct', () {
    test('should return created Product when response code is 201', () async {
      when(mockHttpClient.post(
        Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v3/products'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tProductModel.toJson()),
      )).thenAnswer((_) async => http.Response(fixture('product.json'), 201));

      final result = await dataSource.createProduct(tProductModel);

      expect(result, equals(tProductModel));
    });

    test('should throw ServerException when the response code is not 201', () async {
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Error', 400));

      expect(() => dataSource.createProduct(tProductModel), throwsA(isA<ServerException>()));
    });
  });
}