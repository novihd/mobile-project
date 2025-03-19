import 'package:dartz/dartz.dart';
import 'package:klontong/common/failure.dart';
import 'package:klontong/features/products/data/models/product_payload.dart';
import 'package:klontong/features/products/domain/repositories/product_repository.dart';

class AddProduct {
  final ProductRepository repository;
 
  AddProduct(this.repository);
 
  Future<Either<Failure, String>> execute({required ProductPayload product}) {
    return repository.addProduct(product: product);
  }
}