import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthController extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  Future<void> fetchUserData() async {
    try {
      _user = await AuthService().getMe();
      notifyListeners();
    } catch (e) {
      print("Erro ao buscar dados do usuário: $e");
    }
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}