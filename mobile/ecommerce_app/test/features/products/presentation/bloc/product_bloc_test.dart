import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/domain/usecases/create_product.dart';
import 'package:ecommerce_app/features/products/domain/usecases/delete_product.dart';
import 'package:ecommerce_app/features/products/domain/usecases/update_product.dart';
import 'package:ecommerce_app/features/products/domain/usecases/view_all_products.dart';
import 'package:ecommerce_app/features/products/domain/usecases/view_specific_product.dart';
import 'package:ecommerce_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_bloc_test.mocks.dart';

@GenerateMocks([
  ViewAllProductsUsecase,
  CreateProductUsecase,
  UpdateProductUsecase,
  DeleteProductUsecase,
  ViewProductUsecase,
])
void main() {
  late ProductBloc bloc;
  late MockViewAllProductsUsecase mockViewAllProductsUsecase;
  late MockCreateProductUsecase mockCreateProductUsecase;
  late MockUpdateProductUsecase mockUpdateProductUsecase;
  late MockDeleteProductUsecase mockDeleteProductUsecase;
  late MockViewProductUsecase mockViewProductUsecase;

  setUp(() {
    mockViewAllProductsUsecase = MockViewAllProductsUsecase();
    mockCreateProductUsecase = MockCreateProductUsecase();
    mockUpdateProductUsecase = MockUpdateProductUsecase();
    mockDeleteProductUsecase = MockDeleteProductUsecase();
    mockViewProductUsecase = MockViewProductUsecase();

    bloc = ProductBloc(
      createProduct: mockCreateProductUsecase,
      updateProduct: mockUpdateProductUsecase,
      deleteProduct: mockDeleteProductUsecase,
      viewAllProducts: mockViewAllProductsUsecase,
      viewSpecificProduct: mockViewProductUsecase,
    );
  });

  test('initial state should be InitialState', () {
    expect(bloc.state, equals(InitialState()));
  });

  group('LoadAllProductEvent', () {
    final productList = const [
      Product(
        id: '1',
        name: 'Product 1',
        price: 100,
        description: '',
        imageUrl: '',
      ),
    ];

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, LoadedAllProductState] when products are loaded successfully',
      build: () {
        when(
          mockViewAllProductsUsecase(),
        ).thenAnswer((_) async => Right(productList));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadAllProductEvent()),
      expect: () => [LoadingState(), LoadedAllProductState(productList)],
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, ErrorState] when loading fails',
      build: () {
        when(
          mockViewAllProductsUsecase(),
        ).thenAnswer((_) async => const Left(ServerFailure('Failed to load')));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadAllProductEvent()),
      expect: () => [LoadingState(), const ErrorState('Failed to load')],
    );
  });
  group('GetSingleProductEvent', () {
    final product = const Product(
      id: '1',
      name: 'Product 1',
      price: 100,
      description: '',
      imageUrl: '',
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, LoadedSingleProductState] when a single product is loaded successfully',
      build: () {
        when(
          mockViewProductUsecase('1'),
        ).thenAnswer((_) async => Right(product));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetSingleProductEvent('1')),
      expect: () => [LoadingState(), LoadedSingleProductState(product)],
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, ErrorState] when loading a single product fails',
      build: () {
        when(
          mockViewProductUsecase('1'),
        ).thenAnswer((_) async => const Left(ServerFailure('Failed to load')));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetSingleProductEvent('1')),
      expect: () => [LoadingState(), const ErrorState('Failed to load')],
    );
  });
  group('CreateProductEvent', () {
    final product = const Product(
      id: '1',
      name: 'Product 1',
      price: 100,
      description: '',
      imageUrl: '',
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, LoadedAllProductState] when a product is created successfully',
      build: () {
        when(
          mockCreateProductUsecase(product),
        ).thenAnswer((_) async => Right(product));
        when(
          mockViewAllProductsUsecase(),
        ).thenAnswer((_) async => Right([product]));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(product)),
      expect: () => [
        LoadingState(),
        LoadedAllProductState([product]),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, ErrorState] when creating a product fails',
      build: () {
        when(mockCreateProductUsecase(product)).thenAnswer(
          (_) async => const Left(ServerFailure('Failed to create')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(product)),
      expect: () => [LoadingState(), const ErrorState('Failed to create')],
    );
  });
  group('UpdateProductEvent', () {
    final product = const Product(
      id: '1',
      name: 'Product 1',
      price: 100,
      description: '',
      imageUrl: '',
    );
    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, LoadedAllProductState] when a product is updated successfully',
      build: () {
        when(
          mockUpdateProductUsecase(product),
        ).thenAnswer((_) async => Right(product));
        when(
          mockViewAllProductsUsecase(),
        ).thenAnswer((_) async => Right([product]));
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateProductEvent(product)),
      expect: () => [
        LoadingState(),
        LoadedAllProductState([product]),
      ],
    );
    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, ErrorState] when updating a product fails',
      build: () {
        when(mockUpdateProductUsecase(product)).thenAnswer(
          (_) async => const Left(ServerFailure('Failed to update')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateProductEvent(product)),
      expect: () => [LoadingState(), const ErrorState('Failed to update')],
    );
  });
  group('DeleteProductEvent', () {
    final product = const Product(
      id: '1',
      name: 'Product 1',
      price: 100,
      description: '',
      imageUrl: '',
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, LoadedAllProductState] when a product is deleted successfully',
      build: () {
        when(
          mockDeleteProductUsecase(product.id),
        ).thenAnswer((_) async => Right(product));
        when(
          mockViewAllProductsUsecase(),
        ).thenAnswer((_) async => Right([product]));
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteProductEvent(product.id)),
      expect: () => [LoadingState(), LoadedAllProductState([product])],
    );

    blocTest<ProductBloc, ProductState>(
      'should emit [LoadingState, ErrorState] when deleting a product fails',
      build: () {
        when(mockDeleteProductUsecase(product.id)).thenAnswer(
          (_) async => const Left(ServerFailure('Failed to delete')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteProductEvent(product.id)),
      expect: () => [LoadingState(), const ErrorState('Failed to delete')],
    );
  });
}
