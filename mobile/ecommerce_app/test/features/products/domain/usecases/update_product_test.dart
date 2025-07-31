import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/products/domain/usecases/update_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockProductRepository extends Mock implements ProductRepository {}

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
      imageUrl: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.daily.co%2Fblog%2Fusing-flutter-for-cross-platform-video-application-development%2F&psig=AOvVaw0Fs42TVAznBJ0c9tUVbLLi&ust=1753863978663000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCIC5ktHS4Y4DFQAAAAAdAAAAABAE',
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
