// lib/screens/edit_category_popup.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/category_controller.dart';
import '../models/category.dart';

class EditCategoryPopup extends StatefulWidget {
  final Category category;
  const EditCategoryPopup({Key? key, required this.category}) : super(key: key);

  @override
  _EditCategoryPopupState createState() => _EditCategoryPopupState();
}

class _EditCategoryPopupState extends State<EditCategoryPopup> {
  final _formKey = GlobalKey<FormState>();
  late String _name;

  @override
  void initState(){
    super.initState();
    _name = widget.category.name;
  }

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: Text('Editar Categoria'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          initialValue: _name,
          decoration: InputDecoration(labelText: 'Nome da Categoria'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Informe o nome da categoria' : null,
          onSaved: (value) => _name = value!,
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text('Salvar'),
          onPressed: () {
            if (_formKey.currentState!.validate()){
              _formKey.currentState!.save();
              final updatedCategory = Category(id: widget.category.id, name: _name);
              Provider.of<CategoryController>(context, listen: false)
                  .updateCategory(updatedCategory);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}