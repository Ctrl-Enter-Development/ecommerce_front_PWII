import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_controller.dart';
import '../controllers/role_controller.dart';
import '../models/user.dart';
import '../models/role.dart';

class EditUserPopup extends StatefulWidget {
  final User user;
  const EditUserPopup({Key? key, required this.user}) : super(key: key);

  @override
  _EditUserPopupState createState() => _EditUserPopupState();
}

class _EditUserPopupState extends State<EditUserPopup> {
  final _formKey = GlobalKey<FormState>();
  late String _userName;
  late String _password;
  Role? _selectedRole;

  @override
  void initState(){
    super.initState();
    _userName = widget.user.userName;
    _password = widget.user.password ?? '';
    _selectedRole = Role(id: widget.user.roleId, name: widget.user.role);
    Provider.of<RoleController>(context, listen: false).loadRoles();
  }

  @override
  Widget build(BuildContext context){
    final roles = Provider.of<RoleController>(context).roles;
    return AlertDialog(
      title: Text('Editar Usuário'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _userName,
              decoration: InputDecoration(labelText: 'Nome de Usuário'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Informe o nome de usuário' : null,
              onSaved: (value) => _userName = value!,
            ),
            TextFormField(
              initialValue: _password,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Informe a senha' : null,
              onSaved: (value) => _password = value!,
            ),
            DropdownButtonFormField<Role>(
              value: _selectedRole,
              decoration: InputDecoration(labelText: 'Perfil'),
              items: roles.map((role) {
                return DropdownMenuItem<Role>(
                  value: role,
                  child: Text(role.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Selecione um Perfil' : null,
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
              final updatedUser = User(
                id: widget.user.id,
                userName: _userName,
                password: _password,
                roleId: _selectedRole!.id,
                role: _selectedRole!.name,
              );
              Provider.of<UserController>(context, listen: false)
                  .updateUser(updatedUser);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}