import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:klontong/features/products/persentation/provider/add_product_notifier.dart';
import 'package:klontong/features/products/persentation/provider/get_product_notifier.dart';
import 'package:klontong/features/products/persentation/provider/product_detail_notifier.dart';
import 'package:klontong/firebase_options.dart';
import 'package:klontong/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:klontong/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<GetProductNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AddProductNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ProductDetailNotifier>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}