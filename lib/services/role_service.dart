// lib/services/role_service.dart
import '../models/role.dart';
import '../repositories/role_repository.dart';

class RoleService {
 final RoleRepository _repository = RoleRepository();

 Future<List<Role>> getRoles() {
   return _repository.fetchRoles();
 }

 Future<Role> addRole(Role role) {
   return _repository.createRole(role);
 }

 Future<void> removeRole(int id) {
   return _repository.deleteRole(id);
 }
}