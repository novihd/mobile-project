import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:klontong/common/exception.dart';
import 'package:klontong/common/failure.dart';
import 'package:klontong/common/network_info.dart';
import 'package:klontong/features/products/data/datasources/product_remote_data_source.dart';
import 'package:klontong/features/products/domain/entities/product.dart';
import 'package:klontong/features/products/domain/entities/product_detail.dart';
import 'package:klontong/features/products/data/models/product_payload.dart';
import 'package:klontong/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, ProductDetail>> getProductDetail({required String id}) async {
    try {
      final result = await remoteDataSource.getProductDetail(id: id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts({int page = 1, int limit = 6, String? query}) async {
    try {
      final result = await remoteDataSource.getProducts(searchQuery: query, page: page, limit: limit);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> addProduct({required ProductPayload product}) async {
    try {
      final result = await remoteDataSource.addProduct(product: product);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
