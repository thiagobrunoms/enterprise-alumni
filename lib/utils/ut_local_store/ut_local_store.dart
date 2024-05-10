import 'package:shared_preferences/shared_preferences.dart';

const String _tokenKey = 'token';

class LocalStore {
  static LocalStore instance = LocalStore._();

  LocalStore._();

  Future<String?> loadToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_tokenKey);
  }

  Future<void> saveToken(String? token) async {
    if (token == null) return;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, token);
  }

  Future<void> deleteToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(_tokenKey);
  }
}
