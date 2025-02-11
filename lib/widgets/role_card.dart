// lib/widgets/role_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/role_controller.dart';
import '../screens/edit_role_popup.dart';
import '../models/role.dart';

class RoleCard extends StatelessWidget {
  final Role role;

  RoleCard({required this.role}) : super(key: ValueKey(role.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(role.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => EditRolePopup(role: role),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<RoleController>(context, listen: false)
                    .removeRole(role.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}