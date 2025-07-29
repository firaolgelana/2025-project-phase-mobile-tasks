import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class DeleteProductUsecase {
  final ProductRepository repository;
  const DeleteProductUsecase(this.repository);

  Future<Either<Failure, Product>> call(int id) {
    return repository.deleteProduct(id);
  }
}
