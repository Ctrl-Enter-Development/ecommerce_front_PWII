// lib/repositories/role_repository.dart
import '../models/role.dart';

class RoleRepository {
 final List<Role> _roles = [];
 int _nextId = 1;

 Future<void> _simulateNetworkDelay() async {
   await Future.delayed(Duration(milliseconds: 10));
 }

 Future<List<Role>> fetchRoles() async {
   await _simulateNetworkDelay();
   return List.from(_roles);
 }

 Future<Role> createRole(Role role) async {
   await _simulateNetworkDelay();
   final newRole = Role(id: _nextId++, name: role.name);
   _roles.add(newRole);
   return newRole;
 }

 Future<void> deleteRole(int id) async {
   await _simulateNetworkDelay();
   _roles.removeWhere((role) => role.id == id);
 }
}