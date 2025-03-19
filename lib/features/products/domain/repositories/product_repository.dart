import 'package:dartz/dartz.dart';
import 'package:klontong/common/failure.dart';
import 'package:klontong/features/products/domain/entities/product.dart';
import 'package:klontong/features/products/domain/entities/product_detail.dart';
import 'package:klontong/features/products/data/models/product_payload.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductDetail>> getProductDetail({required String id});
  Future<Either<Failure, List<Product>>> getProducts({int page = 1, int limit = 6, String? query});
  Future<Either<Failure, String>> addProduct({required ProductPayload product});
}