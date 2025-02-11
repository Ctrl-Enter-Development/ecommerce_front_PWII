// lib/screens/category_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/category_controller.dart';
import 'package:ecommerce_front/screens/edit_category_popup.dart';
import 'add_category_popup.dart';

class CategoryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CategoryController>(context, listen: false);
    controller.loadCategories();

    return Scaffold(
      appBar: AppBar(title: Text("Lista de Categorias")),
      body: Consumer<CategoryController>(
        builder: (context, controller, child) {
          if (controller.categories.isEmpty) {
            return const Center(child: Text("Nenhuma categoria cadastrada"));
          }
          return ListView.builder(
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
          return ListTile(
            title: Text(category.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => EditCategoryPopup(category: category),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    controller.removeCategory(category.id);
                  },
                ),
              ],
            ),
          );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddCategoryPopup();
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
