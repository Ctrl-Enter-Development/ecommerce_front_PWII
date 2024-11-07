// lib/screens/subcategory_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/subcategory_controller.dart';
import 'add_subcategory_popup.dart';
import '../widgets/subcategory_card.dart';

class SubCategoryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SubCategoryController>(context, listen: false);
    controller.loadSubCategories();

    return Scaffold(
      appBar: AppBar(title: Text("Lista de Subcategorias")),
      body: Consumer<SubCategoryController>(
        builder: (context, controller, child) {
          if (controller.subCategories.isEmpty) {
            return const Center(child: Text("Nenhuma subcategoria cadastrada"));
          }
          return ListView.builder(
            itemCount: controller.subCategories.length,
            itemBuilder: (context, index) {
              final subCategory = controller.subCategories[index];
              return SubCategoryCard(subCategory: subCategory);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddSubCategoryPopup();
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
