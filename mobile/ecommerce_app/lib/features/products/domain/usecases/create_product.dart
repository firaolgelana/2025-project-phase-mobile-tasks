import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class CreateProductUsecase {
  final ProductRepository repository;
  const CreateProductUsecase(this.repository);

  Future<Either<Failure, Product>> call(Product product) {
    return repository.createProduct(product);
  }
}
