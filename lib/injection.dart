import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:klontong/common/network_info.dart';
import 'package:klontong/features/products/data/datasources/product_remote_data_source.dart';
import 'package:klontong/features/products/data/repositories/product_repositories.dart';
import 'package:klontong/features/products/domain/repositories/product_repository.dart';
import 'package:klontong/features/products/domain/use_case/add_product.dart';
import 'package:klontong/features/products/domain/use_case/get_product_detail.dart';
import 'package:klontong/features/products/domain/use_case/get_products.dart';
import 'package:klontong/features/products/persentation/provider/add_product_notifier.dart';
import 'package:klontong/features/products/persentation/provider/get_product_notifier.dart';
import 'package:klontong/features/products/persentation/provider/product_detail_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(() => GetProductNotifier(getProducts: locator()));
  locator.registerFactory(() => ProductDetailNotifier(getProductDetail: locator()));
  locator.registerFactory(() => AddProductNotifier(addProduct: locator()));

  // use case
  locator.registerLazySingleton(() => AddProduct(locator()));
  locator.registerLazySingleton(() => GetProductDetail(locator()));
  locator.registerLazySingleton(() => GetProducts(locator()));

  // repository
  locator.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(remoteDataSource: locator(), networkInfo: locator()));

  // data sources
  locator.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(client: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());

  //network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  locator.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
