import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class ViewAllProductsUsecase {
  final ProductRepository repository;

  const ViewAllProductsUsecase(this.repository);

  Future<Either<Failure, List<Product>>> call() {
    return repository.getAllProducts();
  }
}
