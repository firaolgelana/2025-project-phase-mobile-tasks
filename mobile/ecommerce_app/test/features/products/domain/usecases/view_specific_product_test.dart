import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/products/domain/usecases/view_specific_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockProductRepository extends Mock implements ProductRepository {}

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
      imageUrl: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.daily.co%2Fblog%2Fusing-flutter-for-cross-platform-video-application-development%2F&psig=AOvVaw0Fs42TVAznBJ0c9tUVbLLi&ust=1753863978663000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCIC5ktHS4Y4DFQAAAAAdAAAAABAE',
    );

    test('should return product by ID via the repository', () async {
      when(mockProductRepository.getProductById(productId)).thenAnswer((_) async => Right(expectedProduct));

      final result = await usecase(productId);

      expect(result, equals(expectedProduct));
      verify(mockProductRepository.getProductById(productId)).called(1);
      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}
