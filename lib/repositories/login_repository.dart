//lib/repositories/login_repository.dart

class LoginRepository {
  // Lista fixa de usuários para simulação de autenticação
  final List<Map<String, String>> _users = [
    {"username": "admin", "password": "123456"},
    {"username": "user", "password": "password"},
  ];

  Future<bool> login(String username, String password) async {
    // Simula um delay para imitar uma requisição real
    await Future.delayed(Duration(seconds: 1));

    // Verifica se as credenciais são válidas
    for (var user in _users) {
      if (user["username"] == username && user["password"] == password) {
        return true; // Credenciais corretas
      }
    }
    return false; // Credenciais inválidas
  }
}