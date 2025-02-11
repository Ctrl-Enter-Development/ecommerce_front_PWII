import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';
import '../controllers/subcategory_controller.dart';
import '../models/product.dart';
import '../models/subcategory.dart';

class EditProductPopup extends StatefulWidget {
  final Product product;

  const EditProductPopup({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductPopupState createState() => _EditProductPopupState();
}

class _EditProductPopupState extends State<EditProductPopup> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _price;
  late String _description;
  SubCategory? _selectedSubCategory;
  Uint8List? _pickedFileBytes;
  String? _pickedFileName;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _name = widget.product.name;
    _price = widget.product.price;
    _description = widget.product.description;

    if (widget.product.subCategoryId != 0) {
      final subCategories =
          Provider.of<SubCategoryController>(context, listen: false).subCategories;
      try {
        _selectedSubCategory = subCategories.firstWhere(
            (subCat) => subCat.id == widget.product.subCategoryId);
      } catch (e) {
        _selectedSubCategory = null;
      }
    } else {
      _selectedSubCategory = null;
    }
  }

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
    final subCategories =
        Provider.of<SubCategoryController>(context).subCategories;
    return AlertDialog(
      title: Text('Editar Produto'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Nome do Produto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome do produto';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: InputDecoration(labelText: 'Preço do Produto'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Informe um preço válido';
                  }
                  return null;
                },
                onSaved: (value) => _price = double.parse(value!),
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a descrição';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text("Selecionar Nova Imagem"),
                  ),
                  SizedBox(width: 8),
                  _pickedFileName != null
                      ? Expanded(child: Text(_pickedFileName!))
                      : Text("Imagem atual mantida"),
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
                value: _selectedSubCategory,
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
                validator: (value) =>
                    value == null ? 'Selecione uma subcategoria' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Salvar'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final updatedProduct = Product(
                id: widget.product.id,
                name: _name,
                price: _price,
                subCategoryId: _selectedSubCategory!.id,
                subCategory: _selectedSubCategory!.name,
                description: _description,
                image: widget.product.image,
              );
              await Provider.of<ProductController>(context, listen: false)
                  .updateProduct(updatedProduct,
                      fileBytes: _pickedFileBytes, fileName: _pickedFileName);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}