import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:klontong/common/constant.dart';
import 'package:klontong/common/exception.dart';
import 'package:klontong/features/products/data/models/product_detail_model.dart';
import 'package:klontong/features/products/data/models/product_model.dart';
import 'package:klontong/features/products/data/models/product_payload.dart';

abstract class ProductRemoteDataSource {
  Future<ProductDetailResponse> getProductDetail({required String id});
  Future<List<ProductModel>> getProducts({int page = 1, int limit = 6, String? searchQuery});
  Future<String> addProduct({required ProductPayload product});
}
 
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
 
  ProductRemoteDataSourceImpl({required this.client});
 
  @override
  Future<ProductDetailResponse> getProductDetail({required String id}) async {
    final response = await client.get(Uri.parse('$BASE_URL/$RESOURCE/$id'));

    if (response.statusCode == 200) {
      return ProductDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

 
  @override
  Future<List<ProductModel>> getProducts({int page = 1, int limit = 6, String? searchQuery}) async {
    final response = await client.get(Uri.parse('$BASE_URL/$RESOURCE'));
 
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<ProductModel> products = data.map((json) => ProductModel.fromJson(json)).toList();
      return products;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> addProduct({required ProductPayload product}) async {
    final response = await client.post(
      Uri.parse('$BASE_URL/$RESOURCE'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 200) {
      return 'Success';
    } else {
      throw ServerException();
    }
  }
}