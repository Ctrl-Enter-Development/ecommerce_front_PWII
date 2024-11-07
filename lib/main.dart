// main.dart
import 'package:ecommerce_front/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/product_controller.dart';
import 'controllers/category_controller.dart'; // Importa o CategoryController
import 'screens/product_list_screen.dart'; // Define a ProductListScreen como tela inicial

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductController()), // Provedor de estado para ProductController
        ChangeNotifierProvider(create: (_) => CategoryController()), // Provedor de estado para CategoryController
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppScaffold(
        bodyContent: ProductListScreen(), // Define a tela inicial como ProductListScreen
      ),
    );
  }
}
