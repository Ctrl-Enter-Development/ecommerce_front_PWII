//lib/controllers/login_controller.dart
import 'package:flutter/material.dart';
import '../services/login_service.dart';

class LoginController extends ChangeNotifier {
  final LoginService _service = LoginService();

  Future<bool> login(String username, String password) async {
    try {
      return await _service.authenticate(username, password);
    } catch (e) {
      print("Erro no login: $e");
      return false;
    }
  }
}