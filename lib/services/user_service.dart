// lib/services/user_service.dart
import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserService {
 final UserRepository _repository = UserRepository();

 Future<List<User>> getUsers() {
   return _repository.fetchUsers();
 }

 Future<User> addUser(User user) {
   return _repository.createUser(user);
 }

 Future<void> removeUser(int id) {
   return _repository.deleteUser(id);
 }
}