import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/products/domain/usecases/delete_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_product_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late DeleteProductUsecase usecase;
  late MockProductRepository mockProductRepository;

  const tProduct = Product(
    id: 1,
    name: 'Sneakers',
    price: 99.99,
    description: 'A comfortable running shoe',
    imageUrl:
        'https://example.com/shoe1.jpg',
  );

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = DeleteProductUsecase(mockProductRepository);
  });

  group('DeleteProductUsecase', () {
    const productId = 1;

    test('should delete product successfully', () async {
      when(mockProductRepository.deleteProduct(productId))
          .thenAnswer((_) async => const Right(tProduct));

      final result = await usecase(productId);

      expect(result, const Right(tProduct));
      verify(mockProductRepository.deleteProduct(productId)).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}