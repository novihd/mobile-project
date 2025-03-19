import 'package:flutter/foundation.dart';
import 'package:klontong/common/state_enum.dart';
import 'package:klontong/features/products/domain/entities/product.dart';
import 'package:klontong/features/products/domain/use_case/get_products.dart';

class GetProductNotifier extends ChangeNotifier {
  final GetProducts getProducts;

  GetProductNotifier({required this.getProducts});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Product> _allProducts = [];
  final List<Product> _paginatedProducts = [];
  List<Product> get getResult => _paginatedProducts;

  String _message = '';
  String get message => _message;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPages = 1;
  int get totalPages => _totalPages;

  final int _limit = 6;

  Future<void> fetchProducts({int page = 1, int limit = 6, String? query}) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getProducts.execute(query: query, page: page, limit: limit);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        //using local pagination when user is scrolling, bcs crudcrud is not support pagination
        _allProducts = data;

        if (query != null && query.isNotEmpty) {
          _allProducts = _allProducts
              .where((product) =>
                  product.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }

        _totalPages = (_allProducts.length / _limit).ceil();
        _currentPage = 1;
        _paginatedProducts.clear();
        _loadPage(_currentPage);
        
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  void _loadPage(int page) {
    int startIndex = (page - 1) * _limit;
    int endIndex = startIndex + _limit;
    endIndex = (endIndex > _allProducts.length) ? _allProducts.length : endIndex;

    _paginatedProducts.addAll(_allProducts.sublist(startIndex, endIndex));
  }

  Future<void> loadMore() async {
    if (_currentPage >= _totalPages) return;
    _currentPage++;
    _loadPage(_currentPage);
    notifyListeners();
  }
}
