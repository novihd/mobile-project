import 'package:dartz/dartz.dart';
import 'package:klontong/common/failure.dart';
import 'package:klontong/features/products/domain/entities/product.dart';
import 'package:klontong/features/products/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;
 
  GetProducts(this.repository);
 
  Future<Either<Failure, List<Product>>> execute({int page = 1, int limit = 6, String? query}) {
    return repository.getProducts(page: page, limit: limit, query: query);
  }
}