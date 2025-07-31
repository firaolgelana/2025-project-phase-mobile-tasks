import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/products/domain/usecases/view_all_products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'create_product_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late ViewAllProductsUsecase usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = ViewAllProductsUsecase(mockProductRepository);
  });

  group('ViewAllProductsUsecase', () {
    final products = [
      const Product(
        id: 1,
        name: 'Sneakers',
        description: 'A comfortable running shoe',
        price: 99.99,
        imageUrl: 'https://example.com/shoe1.jpg',
      ),
      const Product(
        id: 2,
        name: 'Boots',
        description: 'Durable winter boots',
        price: 149.99,
        imageUrl: 'http://example.com/image.jpg',
      ),
    ];

    test('should return all products via the repository', () async {
      when(mockProductRepository.getAllProducts()).thenAnswer((_) async => Right(products));
          //  when(mockProductRepository.updateProduct(updatedProduct))
          // .thenAnswer((_) async => Right(updatedProduct))

      final result = await usecase();

      expect(result, Right(products));
      verify(mockProductRepository.getAllProducts()).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}
