// lib/models/user.dart
import 'role.dart';

class User {
  final int id;
  final String userName;
  final String password;
  final int roleId;
  final String role; // agora é String

  User({
    required this.id,
    required this.userName,
    required this.password,
    required this.roleId,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      userName: json['userName'] as String,
      password: json['password'] as String,
      roleId: json['roleId'] as int,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'password': password,
      'roleId': roleId,
      'role': role,
    };
  }
}