// lib/controllers/role_controller.dart
import 'package:flutter/foundation.dart';
import '../models/role.dart';
import '../services/role_service.dart';

class RoleController extends ChangeNotifier {
  final RoleService _service = RoleService();
  List<Role> _roles = [];

  List<Role> get roles => _roles;

  Future<void> loadRoles() async {
    try {
      _roles = await _service.getRoles();
      notifyListeners();
    } catch (e) {
      print('Error loading roles: $e');
    }
  }

  Future<void> addRole(Role role) async {
    try {
      final addedRole = await _service.addRole(role);
      _roles.add(addedRole);
      notifyListeners();
    } catch (e) {
      print('Error adding role: $e');
    }
  }

  Future<void> removeRole(int id) async {
    try {
      await _service.removeRole(id);
      _roles.removeWhere((role) => role.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting role: $e');
    }
  }
}