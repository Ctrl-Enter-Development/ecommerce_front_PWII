// lib/models/user.dart
import 'role.dart';

class User {
 final int id;
 final String userName;
 final String password;
 final int roleId;
 final Role role;

 User({
   required this.id,
   required this.userName,
   required this.password,
   required this.roleId,
   required this.role,
 });

 factory User.fromJson(Map<String, dynamic> json) {
   return User(
     id: json['id'],
     userName: json['user_name'],
     password: json['password'],
     roleId: json['role_id'],
     role: Role.fromJson(json['role']),
   );
 }

 Map<String, dynamic> toJson() {
   return {
     'id': id,
     'user_name': userName,
     'password': password,
     'role_id': roleId,
     'role': role.toJson(),
   };
 }
}