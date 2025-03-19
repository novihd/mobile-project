import 'dart:math';

import 'package:flutter/material.dart';
import 'package:klontong/common/state_enum.dart';
import 'package:klontong/features/products/domain/entities/product_detail.dart';
import 'package:klontong/features/products/persentation/provider/product_detail_notifier.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final String id;
  const ProductDetailPage({super.key, required this.id});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  Color getRandomColor() {
    return Color.fromARGB(
      255,
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        final provider = Provider.of<ProductDetailNotifier>(context, listen: false);
        provider.fetchProductDetail(widget.id);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
      ),
      body: Consumer<ProductDetailNotifier>(
        builder: (context, data, child) {
        final state = data.productState;
        if (state == RequestState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state == RequestState.Loaded) {
          return content(data.product);
        } else {
          return SizedBox(
            height: 200,
            child: Center(child: Text(data.message)));
        }
      })
    );
  }

  Widget content(ProductDetail product) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 300,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: getRandomColor()),
                  child: Center(child: Text('Gambar ${product.name}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800]),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.price}",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      "${product.rating}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text("Stock: ${product.stock}"),
            Text("Sold: ${product.sold}"),
          ],
        ),
      ),
    );
  }
}