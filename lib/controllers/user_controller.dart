// controllers/user_controller.dart

import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserController extends ChangeNotifier {
 final UserService _service = UserService();
 List<User> _users = [];

 List<User> get users => _users;

 Future<void> loadUsers() async {
   try {
     _users = await _service.getUsers();
     notifyListeners();
   } catch (e) {
     print('Error loading users: $e');
   }
 }

 Future<void> addUser(User user) async {
   try {
     final addedUser = await _service.addUser(user);
     _users.add(addedUser);
     notifyListeners();
   } catch (e) {
     print('Error adding user: $e');
   }
 }

 Future<void> removeUser(int id) async {
   try {
     await _service.removeUser(id);
     _users.removeWhere((user) => user.id == id);
     notifyListeners();
   } catch (e) {
     print('Error deleting user: $e');
   }
 }
}