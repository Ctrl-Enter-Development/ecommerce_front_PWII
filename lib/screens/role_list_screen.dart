// lib/screens/role_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/role_controller.dart';
import '../widgets/role_card.dart';
import 'add_role_popup.dart';

class RoleListScreen extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   final controller = Provider.of<RoleController>(context, listen: false);
   controller.loadRoles();

   return Stack(
     children: [
       Consumer<RoleController>(
         builder: (context, controller, child) {
           if (controller.roles.isEmpty) {
             return const Center(child: Text("Nenhum papel cadastrado"));
           }
           return ListView.builder(
             itemCount: controller.roles.length,
             itemBuilder: (context, index) {
               return RoleCard(role: controller.roles[index]);
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
                 return AddRolePopup();
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