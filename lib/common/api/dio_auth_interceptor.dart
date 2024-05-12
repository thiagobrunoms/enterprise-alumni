import 'package:flutter_test_template/common/api/http_client.dart';

typedef IsTokenExpired = Future<bool> Function();
typedef RefreshToken = Future<(BasicApiFailure?, bool)> Function();
typedef Logout = Future<(BasicApiFailure?, bool)> Function();

class DioAuthInterceptor {
  const DioAuthInterceptor({
    required this.isTokenExpiredCallback,
    required this.refreshTokenCallback,
    required this.logout,
  });

  final IsTokenExpired isTokenExpiredCallback;
  final RefreshToken refreshTokenCallback;
  final Logout logout;
}
