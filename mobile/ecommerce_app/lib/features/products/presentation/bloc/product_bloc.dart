import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/create_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/update_product.dart';
import '../../domain/usecases/view_all_products.dart';
import '../../domain/usecases/view_specific_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final CreateProductUsecase createProduct;
  final UpdateProductUsecase updateProduct;
  final ViewAllProductsUsecase viewAllProducts;
  final ViewProductUsecase viewSpecificProduct;
  final DeleteProductUsecase deleteProduct;
  ProductBloc({
    required this.createProduct, 
    required this.updateProduct, 
    required this.deleteProduct, 
    required this.viewAllProducts, 
    required this.viewSpecificProduct
    }) : super(InitialState()) {
      on<UpdateProductEvent>(_onUpdateProduct);
      on<LoadAllProductEvent>(_onLoadAllProducts);
      on<GetSingleProductEvent>(_onGetSingleProduct);
      on<DeleteProductEvent>(_onDeleteProduct);
      on<CreateProductEvent>(_onCreateProduct);
    }
    void _onLoadAllProducts(LoadAllProductEvent event, Emitter<ProductState> emit) async {
      emit(LoadingState());
      final result = await viewAllProducts();
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (products) => emit(LoadedAllProductState(products)),
      );
    }

    void _onGetSingleProduct(GetSingleProductEvent event, Emitter<ProductState> emit) async {
      emit(LoadingState());
      final result = await viewSpecificProduct(event.productId);
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (product) => emit(LoadedSingleProductState(product)),
      );
    }
    void _onUpdateProduct(UpdateProductEvent event, Emitter<ProductState> emit) async {
      emit(LoadingState());
      final result = await updateProduct(event.product, event.productId);
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (product) => emit(LoadedSingleProductState(product)),
      );
    }
    void _onDeleteProduct(DeleteProductEvent event, Emitter<ProductState> emit) async {
      emit(LoadingState());
      final result = await deleteProduct(event.productId);
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (_) => add(const LoadAllProductEvent()),
      );
    }
    void _onCreateProduct(CreateProductEvent event, Emitter<ProductState> emit) async {
      emit(LoadingState());
      final result = await createProduct(event.product);
      result.fold(
        (failure) => emit(ErrorState(failure.message)),
        (product) => emit(LoadedSingleProductState(product)),
      );
    }
}
