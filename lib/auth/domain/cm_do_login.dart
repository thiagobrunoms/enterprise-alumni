import 'package:flutter_test_template/common/api/api_management.dart';
import 'package:flutter_test_template/common/router/router.dart';

class CmDoLoginParams {
  final String userName;
  final String password;

  CmDoLoginParams({required this.userName, required this.password});
}

Future<bool> cmDoLogin(CmDoLoginParams params) async {
  var response = await api.authentication.login(params.userName, params.password);

  if (response) {
    goRouter.go('/products');
  }

  return response;
}
