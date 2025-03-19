import 'package:dartz/dartz.dart';
import 'package:klontong/common/failure.dart';
import 'package:klontong/features/products/domain/entities/product_detail.dart';
import 'package:klontong/features/products/domain/repositories/product_repository.dart';

class GetProductDetail {
  final ProductRepository repository;
 
  GetProductDetail(this.repository);
 
  Future<Either<Failure, ProductDetail>> execute({required String id}) {
    return repository.getProductDetail(id: id);
  }
}