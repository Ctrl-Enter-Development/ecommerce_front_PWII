// lib/widgets/app_scaffold.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';

import 'package:ecommerce_front/screens/login_screen.dart';
import 'package:ecommerce_front/screens/category_list_screen.dart';
import 'package:ecommerce_front/screens/product_list_screen.dart';
import 'package:ecommerce_front/screens/subcategory_list_screen.dart';
import 'package:ecommerce_front/screens/user_list_screen.dart';
import 'package:ecommerce_front/screens/role_list_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/order_screen.dart';
import 'package:ecommerce_front/controllers/auth_controller.dart';

class AppScaffold extends StatelessWidget {
  final Widget bodyContent;

  AppScaffold({required this.bodyContent});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final authController = Provider.of<AuthController>(context);
    final userName = authController.user?.userName ?? "Usuário";
    final userRole = authController.user?.role ?? "Admin"; 

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
                onSelected: (value) {
                  if (value == 'logout') {
                    storage.remove('authToken');
                    Provider.of<AuthController>(context, listen: false).clearUser();
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
                  child: Text(userName),
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
            if (userRole == "Admin") ...[
              ListTile(
                title: Text('Produtos'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppScaffold(bodyContent: ProductListScreen()),
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
                      builder: (context) => AppScaffold(bodyContent: CategoryListScreen()),
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
                      builder: (context) => AppScaffold(bodyContent: SubCategoryListScreen()),
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
                      builder: (context) => AppScaffold(bodyContent: UserListScreen()),
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
                      builder: (context) => AppScaffold(bodyContent: RoleListScreen()),
                    ),
                  );
                },
              ),
            ],
            if (userRole == "Client") ...[
              ListTile(
                title: Text('Produtos'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppScaffold(bodyContent: ProductListScreen()),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Carrinho'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppScaffold(bodyContent: CartScreen()),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Pedidos'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppScaffold(bodyContent: OrderScreen()),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
      body: bodyContent,
    );
  }
}