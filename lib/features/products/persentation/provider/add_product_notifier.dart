import 'package:flutter/foundation.dart';
import 'package:klontong/common/state_enum.dart';
import 'package:klontong/features/products/data/models/product_payload.dart';
import 'package:klontong/features/products/domain/use_case/add_product.dart';

class AddProductNotifier extends ChangeNotifier {
  final AddProduct addProduct;

  AddProductNotifier({required this.addProduct});

  late AddProduct _product;
  AddProduct get product => _product;

  RequestState _productState = RequestState.Empty;
  RequestState get productState => _productState;

  String _message = '';
  String get message => _message;

  Future<void> postAddProduct(ProductPayload product) async {
    _productState = RequestState.Loading;
    notifyListeners();

    final result = await addProduct.execute(product: product);
    result.fold(
      (failure) {
        _message = failure.message;
        _productState = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _productState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
