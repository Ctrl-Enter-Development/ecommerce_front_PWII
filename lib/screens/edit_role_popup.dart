import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/role_controller.dart';
import '../models/role.dart';

class EditRolePopup extends StatefulWidget {
  final Role role;
  const EditRolePopup({Key? key, required this.role}) : super(key: key);

  @override
  _EditRolePopupState createState() => _EditRolePopupState();
}

class _EditRolePopupState extends State<EditRolePopup> {
  final _formKey = GlobalKey<FormState>();
  late String _name;

  @override
  void initState(){
    super.initState();
    _name = widget.role.name;
  }

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: Text('Editar Perfil'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          initialValue: _name,
          decoration: InputDecoration(labelText: 'Nome do Perfil'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Informe o nome do Perfil' : null,
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
              final updatedRole = Role(id: widget.role.id, name: _name);
              Provider.of<RoleController>(context, listen: false)
                  .updateRole(updatedRole);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}