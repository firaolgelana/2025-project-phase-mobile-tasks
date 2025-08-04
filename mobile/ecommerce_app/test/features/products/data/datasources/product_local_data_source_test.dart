import 'dart:convert';

import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/products/data/datasources/product_local_data_source.dart';
import 'package:ecommerce_app/features/products/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'product_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late ProductLocalDataSourceImp dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImp(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getCachedProducts', () {
    final jsonString = fixture('product_cached.json');
    final tProductList = [
      ProductModel.fromJson(json.decode(jsonString) as Map<String, dynamic>),
    ];

    test(
      'should return product list from shared preferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getStringList(any)).thenReturn([jsonString]);

        // act
        final result = await dataSource.getCachedProducts();

        // assert
        verify(mockSharedPreferences.getStringList('CACHED_PRODUCTS'));
        expect(result, equals(tProductList));
      },
    );
    test(
      'should throw a cache exception when there is not a cached value',
      () async {
        // arrange
        when(mockSharedPreferences.getStringList(any)).thenReturn(null);

        // act
        final call = dataSource.getCachedProducts;

        // assert
        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });
  group('getProductById', () {
    test(
      'should return the product with the given ID from shared preferences',
      () async {
        // arrange
        final jsonString = fixture(
          'product_cached.json',
        ); // one product with id=1
        when(mockSharedPreferences.getStringList(any)).thenReturn([jsonString]);

        // act
        final result = await dataSource.getProductById('1');

        // assert
        final expectedProduct = ProductModel.fromJson(
          json.decode(jsonString) as Map<String, dynamic>,
        );
        verify(mockSharedPreferences.getStringList('CACHED_PRODUCTS'));
        expect(result, equals(expectedProduct));
      },
    );

    test(
      'should throw CacheException when product with given ID not found',
      () async {
        // arrange
        final jsonString = fixture('product_cached.json'); // only id=1 exists
        when(mockSharedPreferences.getStringList(any)).thenReturn([jsonString]);

        // act & assert
        expect(
          () => dataSource.getProductById('999'),
          throwsA(isA<CacheException>()),
        );
      },
    );
  });
  group('cacheProduct', () {
    test(
      'should cache the product by adding it to shared preferences',
      () async {
        // arrange
        final productJson = fixture('product_cached.json');
        final productModel = ProductModel.fromJson(json.decode(productJson));
        final encodedProduct = json.encode(productModel.toJson());

        when(mockSharedPreferences.getStringList(any)).thenReturn([]);
        when(
          mockSharedPreferences.setStringList(any, any),
        ).thenAnswer((_) async => true);

        // act
        await dataSource.cacheProduct(productModel);

        // assert
        verify(
          mockSharedPreferences.setStringList('CACHED_PRODUCTS', [
            encodedProduct,
          ]),
        );
      },
    );
  });
  group('cacheProducts', () {
    test('should cache list of products in shared preferences', () async {
      // arrange
      final productJson = fixture('product_cached.json');
      final productModel = ProductModel.fromJson(json.decode(productJson));
      final expectedList = [json.encode(productModel.toJson())];

      when(
        mockSharedPreferences.setStringList(any, any),
      ).thenAnswer((_) async => true);

      // act
      await dataSource.cacheProducts([productModel]);

      // assert
      verify(
        mockSharedPreferences.setStringList('CACHED_PRODUCTS', expectedList),
      );
    });
  });
  group('clearCache', () {
    test('should remove cached products from shared preferences', () async {
      // arrange
      when(mockSharedPreferences.remove(any)).thenAnswer((_) async => true);

      // act
      await dataSource.clearCache();

      // assert
      verify(mockSharedPreferences.remove('CACHED_PRODUCTS'));
    });

  });
}
