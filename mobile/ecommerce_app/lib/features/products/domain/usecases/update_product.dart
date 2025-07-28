import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProductUsecase {
  final ProductRepository repository;
  UpdateProductUsecase(this.repository);

  Future<Either<Failure, Product>> call(Product product) {
    return repository.updateProduct(product);
  }
}
