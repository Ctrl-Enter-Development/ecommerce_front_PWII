// lib/widgets/subcategory_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/subcategory_controller.dart';
import '../screens/edit_subcategory_popup.dart';
import '../models/subcategory.dart';

class SubCategoryCard extends StatelessWidget {
  final SubCategory subCategory;

  SubCategoryCard({required this.subCategory}) : super(key: ValueKey(subCategory.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(subCategory.name),
        subtitle: Text('Categoria: ${subCategory.category}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => EditSubCategoryPopup(subCategory: subCategory),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<SubCategoryController>(context, listen: false)
                    .removeSubCategory(subCategory.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}