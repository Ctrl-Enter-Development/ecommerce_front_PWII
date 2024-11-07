// main.dart
import 'package:ecommerce_front/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/product_controller.dart';
import 'controllers/category_controller.dart';
import 'controllers/subcategory_controller.dart'; // Importa o SubCategoryController
import 'screens/product_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductController()),
        ChangeNotifierProvider(create: (_) => CategoryController()),
        ChangeNotifierProvider(create: (_) => SubCategoryController()), // Provedor para SubCategoryController
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
        bodyContent: ProductListScreen(),
      ),
    );
  }
}
