import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/products/domain/usecases/create_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'create_product_test.mocks.dart'; 

@GenerateMocks([ProductRepository])
void main() {
  late CreateProductUsecase usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = CreateProductUsecase(mockProductRepository);
  });

  group('CreateProductUsecase', () {
    final newProduct = const Product(
      id: 2,
      name: 'New Sneakers',
      description: 'A brand new sneaker model',
      price: 129.99,
      imageUrl: 'http://example.com/image.jpg',
    );

    test('should create product successfully', () async {
      when(mockProductRepository.createProduct(newProduct))
          .thenAnswer((_) async => Right(newProduct));

      final result = await usecase(newProduct);

      expect(result, Right(newProduct));
      verify(mockProductRepository.createProduct(newProduct)).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}
