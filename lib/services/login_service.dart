//lib/services/login_service.dart
import '../repositories/login_repository.dart';

class LoginService {
  final LoginRepository _repository = LoginRepository();

  Future<bool> authenticate(String username, String password) async {
    return await _repository.login(username, password);
  }
}