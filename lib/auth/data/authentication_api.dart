import '../../common/api/http_client.dart';

abstract class AuthenticationApi {
  Future<(BasicApiFailure?, bool)> login(String userName, String password);
  Future<(BasicApiFailure?, bool)> logout();
  Future<bool> isLoggedIn();
  Future<bool> isTokenExpired();
  Future<(BasicApiFailure?, bool)> refreshToken();
  String? getToken();
}
