import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/subcategory_controller.dart';
import '../controllers/category_controller.dart';
import '../models/subcategory.dart';
import '../models/category.dart';

class EditSubCategoryPopup extends StatefulWidget {
  final SubCategory subCategory;
  const EditSubCategoryPopup({Key? key, required this.subCategory}) : super(key: key);

  @override
  _EditSubCategoryPopupState createState() => _EditSubCategoryPopupState();
}

class _EditSubCategoryPopupState extends State<EditSubCategoryPopup> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  Category? _selectedCategory;

  @override
  void initState(){
    super.initState();
    _name = widget.subCategory.name;
    _selectedCategory = Category(
      id: widget.subCategory.categoryId,
      name: widget.subCategory.category,
    );
    Provider.of<CategoryController>(context, listen: false).loadCategories();
  }

  @override
  Widget build(BuildContext context){
    final categories = Provider.of<CategoryController>(context).categories;
    return AlertDialog(
      title: Text('Editar Subcategoria'),
      content: Form(
         key: _formKey,
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             TextFormField(
               initialValue: _name,
               decoration: InputDecoration(labelText: 'Nome da Subcategoria'),
               validator: (value) =>
                   value == null || value.isEmpty ? 'Informe o nome da subcategoria' : null,
               onSaved: (value) => _name = value!,
             ),
             DropdownButtonFormField<Category>(
               value: _selectedCategory,
               decoration: InputDecoration(labelText: 'Categoria'),
               items: categories.map((category) {
                 return DropdownMenuItem<Category>(
                   value: category,
                   child: Text(category.name),
                 );
               }).toList(),
               onChanged: (value) {
                 setState(() {
                   _selectedCategory = value;
                 });
               },
               validator: (value) => value == null ? 'Selecione uma categoria' : null,
             ),
           ],
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
                final updatedSubCategory = SubCategory(
                  id: widget.subCategory.id,
                  name: _name,
                  categoryId: _selectedCategory!.id,
                  category: _selectedCategory!.name,
                );
                Provider.of<SubCategoryController>(context, listen: false)
                    .updateSubCategory(updatedSubCategory);
                Navigator.pop(context);
              }
            },
         ),
      ],
    );
  }
}