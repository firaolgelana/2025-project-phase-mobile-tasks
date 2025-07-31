import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/products/domain/usecases/delete_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late DeleteProductUsecase usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = DeleteProductUsecase(mockProductRepository);
  });

  group('DeleteProductUsecase', () {
    const productId = 1;

    test('should delete product successfully', () async {
      when(mockProductRepository.deleteProduct(productId))
          .thenAnswer((_) async => Right(productId as Product)); 

      final result = await usecase(productId);

      expect(result, Right(productId as Product));
      verify(mockProductRepository.deleteProduct(productId)).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });

  });
}
