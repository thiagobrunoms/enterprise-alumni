import 'package:flutter_test_template/common/api/api_management.dart';
import 'package:flutter_test_template/common/api/http_client.dart';
import 'package:flutter_test_template/utils/router/router.dart';

class CmDoLoginParams {
  final String userName;
  final String password;

  CmDoLoginParams({required this.userName, required this.password});
}

Future<(BasicApiFailure?, bool)> cmDoLogin(CmDoLoginParams params) async {
  var response = await api.authentication.login(params.userName, params.password);

  if (response.$2) {
    goRouter.go('/products');
  }

  return response;
}
