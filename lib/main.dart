// ==== lib/main.dart ====
import 'package:ecommerce_front/controllers/category_controller.dart';
import 'package:ecommerce_front/controllers/login_controller.dart';
import 'package:ecommerce_front/controllers/role_controller.dart';
import 'package:ecommerce_front/controllers/subcategory_controller.dart';
import 'package:ecommerce_front/controllers/user_controller.dart';
import 'package:ecommerce_front/screens/login_screen.dart';
import 'controllers/auth_controller.dart';
import 'controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/product_controller.dart';

// Import para o serviço de autenticação, usado para validar o token.
import 'package:ecommerce_front/services/auth_service.dart';
// Import do AppScaffold e tela principal
import 'package:ecommerce_front/widgets/app_scaffold.dart';
import 'package:ecommerce_front/screens/product_list_screen.dart';
import 'package:ecommerce_front/utils/app_storage.dart';
import 'package:ecommerce_front/models/user.dart';

void main() async {
  await GetStorage.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductController()),
        ChangeNotifierProvider(create: (_) => CategoryController()),
        ChangeNotifierProvider(create: (_) => SubCategoryController()),
        // Certifique-se de não criar dois ProductController se não for intencional
        // ChangeNotifierProvider(create: (_) => ProductController()),
        ChangeNotifierProvider(create: (_) => RoleController()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => CartController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final String? token = AppStorage.instance.token;

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Product App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: token == null 
          ? LoginScreen()
          : FutureBuilder<User>(
              future: AuthService().getMe(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                else if (snapshot.hasError) {
                  AppStorage.instance.removeToken();
                  return LoginScreen();
                }
                else if (snapshot.hasData) {
                  return AppScaffold(bodyContent: ProductListScreen());
                }
                else {
                  return LoginScreen();
                }
              },
            ),
    );
  }
}