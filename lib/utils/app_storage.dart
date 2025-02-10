import 'package:get_storage/get_storage.dart';

class AppStorage {
  AppStorage._internal();

  static final AppStorage instance = AppStorage._internal();

  factory AppStorage() => instance;

  static const String tokenKey = 'authToken';

  final GetStorage storage = GetStorage();

  String? get token => storage.read(tokenKey);

  void setToken(String? token) =>
      token == null ? storage.remove(tokenKey) : storage.write(tokenKey, token);

  void removeToken() {
    storage.remove(tokenKey);
  }
}