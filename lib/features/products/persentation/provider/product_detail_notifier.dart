import 'package:flutter/foundation.dart';
import 'package:klontong/common/state_enum.dart';
import 'package:klontong/features/products/domain/entities/product_detail.dart';
import 'package:klontong/features/products/domain/use_case/get_product_detail.dart';

class ProductDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetProductDetail getProductDetail;

  ProductDetailNotifier({required this.getProductDetail});

  late ProductDetail _product;
  ProductDetail get product => _product;

  RequestState _productState = RequestState.Empty;
  RequestState get productState => _productState;

  String _message = '';
  String get message => _message;

  Future<void> fetchProductDetail(String id) async {
    _productState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getProductDetail.execute(id: id);
    detailResult.fold(
      (failure) {
        _productState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (product) {
        _product = product;
        _productState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
