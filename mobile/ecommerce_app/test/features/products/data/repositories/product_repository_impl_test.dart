import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:ecommerce_app/features/products/data/datasources/product_local_data_source.dart';
import 'package:ecommerce_app/features/products/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockProductRemoteDataSource extends Mock implements ProductRemoteDataSource {}

class MockProductLocalDataSource extends Mock implements ProductLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  final tProductList = const [
    Product(
      id: 1,
      name: 'Test Product',
      price: 10.0,
      description: 'Test Description',
      imageUrl: 'http://example.com/image.jpg',
    ),
    Product(
      id: 2,
      name: 'Second Product',
      price: 24.5,
      description: 'Another description',
      imageUrl: 'http://example.com/image2.jpg',
    ),
  ];

  final tProduct = tProductList[0];

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getAllProducts', () {
    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      await repository.getAllProducts();
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote products on success', () async {
        when(mockRemoteDataSource.getAllProducts()).thenAnswer((_) async => tProductList);

        final result = await repository.getAllProducts();

        verify(mockRemoteDataSource.getAllProducts());
        expect(result, Right(tProductList));
      });

      test('should return ServerFailure on exception', () async {
        when(mockRemoteDataSource.getAllProducts()).thenThrow(ServerException());

        final result = await repository.getAllProducts();

        expect(result, const Left(ServerFailure('server error')));
      });
    });

    runTestsOffline(() {
      test('should return cached products when offline', () async {
        when(mockLocalDataSource.getLastProducts()).thenAnswer((_) async => tProductList);

        final result = await repository.getAllProducts();

        verify(mockLocalDataSource.getLastProducts());
        expect(result, Right(tProductList));
      });

      test('should return CacheFailure when no cache', () async {
        when(mockLocalDataSource.getLastProducts()).thenThrow(CacheException());

        final result = await repository.getAllProducts();

        expect(result, const Left(CacheFailure('No cached products available')));
      });
    });
  });

  group('getProductById', () {
    runTestsOnline(() {
      test('should return product from remote datasource', () async {
        when(mockRemoteDataSource.getProductById(1)).thenAnswer((_) async => tProduct);

        final result = await repository.getProductById(1);

        verify(mockRemoteDataSource.getProductById(1));
        expect(result, Right(tProduct));
      });
    });

    runTestsOffline(() {
      test('should return product from local datasource', () async {
        when(mockLocalDataSource.getProductById(1)).thenAnswer((_) async => tProduct);

        final result = await repository.getProductById(1);

        verify(mockLocalDataSource.getProductById(1));
        expect(result, Right(tProduct));
      });

      test('should return CacheFailure when no cached product', () async {
        when(mockLocalDataSource.getProductById(1)).thenThrow(CacheException());

        final result = await repository.getProductById(1);

        expect(result, const Left(CacheFailure('No cached product found')));
      });
    });
  });

  group('createProduct', () {
    runTestsOnline(() {
      test('should create product remotely', () async {
        when(mockRemoteDataSource.createProduct(tProduct)).thenAnswer((_) async => tProduct);

        final result = await repository.createProduct(tProduct);

        verify(mockRemoteDataSource.createProduct(tProduct));
        expect(result, Right(tProduct));
      });

      test('should return ServerFailure when remote creation fails', () async {
        when(mockRemoteDataSource.createProduct(tProduct)).thenThrow(ServerException());

        final result = await repository.createProduct(tProduct);

        expect(result, const Left(ServerFailure('Failed to create product')));
      });
    });

    runTestsOffline(() {
      test('should return NetworkFailure when offline', () async {
        final result = await repository.createProduct(tProduct);

        expect(result, const Left(NetworkFailure('No internet connection')));
      });
    });
  });

  group('updateProduct', () {
    runTestsOnline(() {
      test('should update product remotely', () async {
        when(mockRemoteDataSource.updateProduct(tProduct)).thenAnswer((_) async => tProduct);

        final result = await repository.updateProduct(tProduct);

        verify(mockRemoteDataSource.updateProduct(tProduct));
        expect(result, Right(tProduct));
      });

      test('should return ServerFailure when update fails', () async {
        when(mockRemoteDataSource.updateProduct(tProduct)).thenThrow(ServerException());

        final result = await repository.updateProduct(tProduct);

        expect(result, const Left(ServerFailure('Failed to update product')));
      });
    });

    runTestsOffline(() {
      test('should return NetworkFailure when offline', () async {
        final result = await repository.updateProduct(tProduct);

        expect(result, const Left(NetworkFailure('No internet connection')));
      });
    });
  });

  group('deleteProduct', () {
    runTestsOnline(() {
      test('should delete product remotely', () async {
        when(mockRemoteDataSource.deleteProduct(1)).thenAnswer((_) async => tProduct);

        final result = await repository.deleteProduct(1);

        verify(mockRemoteDataSource.deleteProduct(1));
        expect(result, Right(tProduct));
      });

      test('should return ServerFailure when deletion fails', () async {
        when(mockRemoteDataSource.deleteProduct(1)).thenThrow(ServerException());

        final result = await repository.deleteProduct(1);

        expect(result, const Left(ServerFailure('Failed to delete product')));
      });
    });

    runTestsOffline(() {
      test('should return NetworkFailure when offline', () async {
        final result = await repository.deleteProduct(1);

        expect(result, const Left(NetworkFailure('No internet connection')));
      });
    });
  });
}
