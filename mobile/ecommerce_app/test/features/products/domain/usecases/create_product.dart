import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/products/domain/usecases/create_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late CreateProductUsecase usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = CreateProductUsecase(mockProductRepository);
  });

  group('CreateProductUsecase', () {
    final newProduct = Product(
      id: 2,
      name: 'New Sneakers',
      description: 'A brand new sneaker model',
      price: 129.99,
      imageUrl: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.daily.co%2Fblog%2Fusing-flutter-for-cross-platform-video-application-development%2F&psig=AOvVaw0Fs42TVAznBJ0c9tUVbLLi&ust=1753863978663000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCIC5ktHS4Y4DFQAAAAAdAAAAABAE',
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
