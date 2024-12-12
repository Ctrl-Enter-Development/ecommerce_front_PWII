// lib/widgets/app_scaffold.dart
import 'package:ecommerce_front/screens/category_list_screen.dart';
import 'package:ecommerce_front/screens/product_list_screen.dart';
import 'package:ecommerce_front/screens/subcategory_list_screen.dart';
import 'package:ecommerce_front/screens/user_list_screen.dart';
import 'package:ecommerce_front/screens/role_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_front/screens/login_screen.dart';
import 'package:get_storage/get_storage.dart'; // Importa GetStorage

class AppScaffold extends StatelessWidget {
  final Widget bodyContent;

  AppScaffold({required this.bodyContent});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage(); // Instância do GetStorage

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
        actions: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar.png"),
              ),
              SizedBox(width: 8),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'logout') {
                    // Remove o token do armazenamento
                    await storage.remove('authToken');
                    
                    // Redireciona para a tela de login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
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
              title: Text('Subcategorias'),
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
            ListTile(
              title: Text('Usuários'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffold(bodyContent: UserListScreen()),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Perfil'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppScaffold(bodyContent: RoleListScreen()),
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
