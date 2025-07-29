import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class ViewProductUsecase {
  final ProductRepository repository;
  const ViewProductUsecase(this.repository);

  Future<Either<Failure, Product>> call(int id) {
    return repository.getProductById(id);
  }
}
