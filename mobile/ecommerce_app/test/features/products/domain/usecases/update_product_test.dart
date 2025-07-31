import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/products/domain/usecases/update_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'update_product_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late UpdateProductUsecase usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = UpdateProductUsecase(mockProductRepository);
  });

  group('UpdateProductUsecase', () {
    final updatedProduct = const Product(
      id: 1,
      name: 'Updated Sneakers',
      description: 'Updated description',
      price: 119.99,
      imageUrl: 'http://example.com/image.jpg',
    );

    test('should update product successfully', () async {
      when(mockProductRepository.updateProduct(updatedProduct))
          .thenAnswer((_) async => Right(updatedProduct));

      final result = await usecase(updatedProduct);

      expect(result, Right(updatedProduct));
      verify(mockProductRepository.updateProduct(updatedProduct)).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}
