import 'dart:async';

import 'package:flutter/material.dart';
import 'package:klontong/common/state_enum.dart';
import 'package:klontong/features/products/persentation/pages/product_card.dart';
import 'package:klontong/features/products/persentation/pages/product_detail_page.dart';
import 'package:klontong/features/products/persentation/provider/get_product_notifier.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ScrollController _scrollController = ScrollController();
  final int _itemsPerPage = 8;
  String? _searchQuery;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        final provider = Provider.of<GetProductNotifier>(context, listen: false);
        provider.fetchProducts(
          page: 1,
          limit: _itemsPerPage,
          query: _searchQuery,
        );
      }
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        Provider.of<GetProductNotifier>(context, listen: false).loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: Colors.lightBlueAccent,
      onRefresh: () async {
        return Future.microtask(
          () {
            final provider = Provider.of<GetProductNotifier>(context, listen: false);
            provider.fetchProducts(
              page: provider.currentPage,
              limit: 6,
              query: '',
            );
          },
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: TextFormField(
              onChanged: (value) {
                if (value.isNotEmpty && value.trim().isNotEmpty) {
                  Timer(const Duration(seconds: 3), () {
                    Provider.of<GetProductNotifier>(context, listen: false).fetchProducts(      
                      query: value,
                    );
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<GetProductNotifier>(builder: (context, data, child) {
                    final state = data.state;
                    if (state == RequestState.Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.Loaded) {
                      return Column(
                        children: data.getResult.map((e) => 
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(id: e.id)));
                            },
                            child: ProductCard(product: e))
                          ).toList(),
                      );
                    } else {
                      return SizedBox(
                        height: 200,
                        child: Center(child: Text(data.message)));
                    }
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}