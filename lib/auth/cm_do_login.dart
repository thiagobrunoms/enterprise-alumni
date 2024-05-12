import 'package:flutter_test_template/common/api/api_management.dart';
import 'package:flutter_test_template/common/api/http_client.dart';

class CmDoLoginParams {
  final String userName;
  final String password;

  CmDoLoginParams({required this.userName, required this.password});
}

Future<(BasicApiFailure?, bool)> cmDoLogin(CmDoLoginParams params) async {
  return await api.authentication.login(params.userName, params.password);
}
