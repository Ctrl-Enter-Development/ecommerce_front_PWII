
// lib/repositories/user_repository.dart
import '../models/user.dart';

class UserRepository {
 final List<User> _users = [];
 int _nextId = 1;

 Future<void> _simulateNetworkDelay() async {
   await Future.delayed(Duration(milliseconds: 10));
 }

 Future<List<User>> fetchUsers() async {
   await _simulateNetworkDelay();
   return List.from(_users);
 }

 Future<User> createUser(User user) async {
   await _simulateNetworkDelay();
   final newUser = User(
     id: _nextId++,
     userName: user.userName,
     password: user.password,
     roleId: user.roleId,
     role: user.role,
   );
   _users.add(newUser);
   return newUser;
 }

 Future<void> deleteUser(int id) async {
   await _simulateNetworkDelay();
   _users.removeWhere((user) => user.id == id);
 }
}