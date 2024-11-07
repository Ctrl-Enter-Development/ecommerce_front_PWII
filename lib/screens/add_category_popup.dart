// lib/screens/add_category_popup.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/category_controller.dart';
import '../models/category.dart';

class AddCategoryPopup extends StatefulWidget {
  @override
  _AddCategoryPopupState createState() => _AddCategoryPopupState();
}

class _AddCategoryPopupState extends State<AddCategoryPopup> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Categoria'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Nome da Categoria'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe o nome da categoria';
            }
            return null;
          },
          onSaved: (value) {
            _name = value!;
          },
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Adicionar'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final newCategory = Category(id: 0, name: _name);
              Provider.of<CategoryController>(context, listen: false)
                  .addCategory(newCategory);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
