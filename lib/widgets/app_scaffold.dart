// lib/widgets/app_scaffold.dart

import 'package:ecommerce_front/screens/category_list_screen.dart';
import 'package:ecommerce_front/screens/product_list_screen.dart';
import 'package:ecommerce_front/screens/subcategory_list_screen.dart'; // Importa a tela de subcategorias
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget bodyContent;

  AppScaffold({required this.bodyContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product App"),
        actions: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar.png"),
              ),
              SizedBox(width: 8),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'logout') {
                    print("Logout acionado");
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'logout',
                      child: Text('Logout'),
                    ),
                  ];
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Nome do Usuário"),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Produtos'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffold(bodyContent: ProductListScreen()),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Categorias'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffold(bodyContent: CategoryListScreen()),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Subcategorias'), // Novo item para SubCategorias
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffold(bodyContent: SubCategoryListScreen()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: bodyContent,
    );
  }
}
