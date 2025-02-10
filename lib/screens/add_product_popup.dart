// lib/screens/add_product_popup.dart
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';
import '../controllers/subcategory_controller.dart';
import '../models/product.dart';
import '../models/subcategory.dart';

class AddProductPopup extends StatefulWidget {
  @override
  _AddProductPopupState createState() => _AddProductPopupState();
}

class _AddProductPopupState extends State<AddProductPopup> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _price = 0.0;
  String _description = '';
  SubCategory? _selectedSubCategory;

  Uint8List? _pickedFileBytes;
  String? _pickedFileName;
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _pickedFileBytes = result.files.first.bytes;
        _pickedFileName = result.files.first.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final subCategories = Provider.of<SubCategoryController>(context).subCategories;
    return AlertDialog(
      title: Text('Adicionar Produto'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome do Produto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome do produto';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preço do Produto'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Informe um preço válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a descrição';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text("Selecionar Imagem"),
                  ),
                  SizedBox(width: 8),
                  _pickedFileName != null
                      ? Expanded(child: Text(_pickedFileName!))
                      : Text("Nenhuma imagem selecionada"),
                ],
              ),
              if (_isUploading) CircularProgressIndicator(),
              if (_pickedFileBytes != null)
                Container(
                  margin: EdgeInsets.only(top: 8),
                  width: 100,
                  height: 100,
                  child: Image.memory(_pickedFileBytes!, fit: BoxFit.cover),
                ),
              DropdownButtonFormField<SubCategory>(
                decoration: InputDecoration(labelText: 'Subcategoria'),
                items: subCategories.map((subCategory) {
                  return DropdownMenuItem<SubCategory>(
                    value: subCategory,
                    child: Text(subCategory.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSubCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione uma subcategoria';
                  }
                  return null;
                },
              ),
            ],
          ),
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
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (_pickedFileBytes == null || _pickedFileName == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Selecione uma imagem para o produto.")),
                );
                return;
              }
              _formKey.currentState!.save();
              final newProduct = Product(
                id: 0,
                name: _name,
                price: _price,
                subCategoryId: _selectedSubCategory!.id,
                subCategory: _selectedSubCategory!.name,
                description: _description,
                image: null, 
              );
              await Provider.of<ProductController>(context, listen: false)
                  .addProductWithFile(newProduct, fileBytes: _pickedFileBytes, fileName: _pickedFileName);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}