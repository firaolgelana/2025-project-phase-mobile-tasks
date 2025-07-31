import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/products/domain/usecases/view_specific_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'view_specific_product_test.mocks.dart';


@GenerateMocks([ProductRepository])
void main() {
  late ViewProductUsecase usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = ViewProductUsecase(mockProductRepository);
  });

  group('ViewProductUsecase', () {
    const productId = 1;
    final expectedProduct = const Product(
      id: 1,
      name: 'Sneakers',
      description: 'A comfortable running shoe',
      price: 99.99,
      imageUrl: 'http://example.com/image.jpg',
    );

    test('should return product by ID via the repository', () async {
      when(mockProductRepository.getProductById(productId)).thenAnswer((_) async => Right(expectedProduct));

      final result = await usecase(productId);

      expect(result, Right(expectedProduct));
      verify(mockProductRepository.getProductById(productId)).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}
