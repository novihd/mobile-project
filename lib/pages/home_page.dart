import 'package:flutter/material.dart';
import 'package:klontong/features/products/persentation/pages/add_product_page.dart';
import 'package:klontong/features/products/persentation/pages/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Klontong')),
      body: const ProductPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductPage()));
        },
        child: const Icon(Icons.add)),
    );
  }
}
