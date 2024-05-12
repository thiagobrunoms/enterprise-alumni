abstract class AuthenticationApi {
  Future<bool> login(String userName, String password);
  Future<bool> logout();
  Future<bool> isLoggedIn();
  Future<bool> isTokenExpired();
  Future<bool> refreshToken();
  String? getToken();
}
