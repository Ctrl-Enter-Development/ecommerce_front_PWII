// main.dart
import 'package:ecommerce_front/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/product_controller.dart'; // Importa o ProductController para gerenciar o estado dos produtos
import 'screens/product_list_screen.dart'; // Define a ProductListScreen como tela inicial

void main() {
  // Inicia o app com MultiProvider para gerenciar múltiplos controladores de estado
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductController()), // Inicia o ProductController como provedor de estado
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
        primarySwatch: Colors.blue, // Define a cor padrão do tema
      ),
      home: AppScaffold(
        bodyContent: ProductListScreen(), // Define a tela inicial como ProductListScreen
      ),
    );
  }
}