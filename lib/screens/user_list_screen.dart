// lib/screens/user_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_controller.dart';
import '../widgets/user_card.dart';
import 'add_user_popup.dart';

class UserListScreen extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   final controller = Provider.of<UserController>(context, listen: false);
   controller.loadUsers();

   return Stack(
     children: [
       Consumer<UserController>(
         builder: (context, controller, child) {
           if (controller.users.isEmpty) {
             return const Center(child: Text("Nenhum usuário cadastrado"));
           }
           return ListView.builder(
             itemCount: controller.users.length,
             itemBuilder: (context, index) {
               return UserCard(user: controller.users[index]);
             },
           );
         },
       ),
       Positioned(
         bottom: 16,
         right: 16,
         child: FloatingActionButton(
           onPressed: () {
             showDialog(
               context: context,
               builder: (BuildContext context) {
                 return AddUserPopup();
               },
             );
           },
           child: Icon(Icons.add),
           backgroundColor: Colors.blue,
         ),
       ),
     ],
   );
 }
}

