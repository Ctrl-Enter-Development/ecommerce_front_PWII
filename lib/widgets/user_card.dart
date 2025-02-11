// lib/widgets/user_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_controller.dart';
import '../screens/edit_user_popup.dart';
import '../models/user.dart';

class UserCard extends StatelessWidget {
  final User user;

  UserCard({required this.user}) : super(key: ValueKey(user.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(user.userName),
        subtitle: Text(user.role),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => EditUserPopup(user: user),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<UserController>(context, listen: false)
                    .removeUser(user.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}