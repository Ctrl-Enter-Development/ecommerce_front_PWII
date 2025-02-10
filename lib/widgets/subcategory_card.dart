// lib/widgets/subcategory_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/subcategory_controller.dart';
import '../models/subcategory.dart';

class SubCategoryCard extends StatelessWidget {
  final SubCategory subCategory;

  SubCategoryCard({required this.subCategory}) : super(key: ValueKey(subCategory.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(subCategory.name),
        subtitle: Text(
          'Categoria: ${subCategory.category}',
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            Provider.of<SubCategoryController>(context, listen: false)
                .removeSubCategory(subCategory.id);
          },
        ),
      ),
    );
  }
}
