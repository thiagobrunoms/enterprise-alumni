import 'package:flutter_test_template/utils/ut_dummy_json_api/ut_dummy_json_api.dart';

class CmDoLoginParams {
  final String userName;
  final String password;

  CmDoLoginParams({required this.userName, required this.password});
}

Future<bool> cmDoLogin(CmDoLoginParams params) async {
  return await utJsonDummyApi.login(params.userName, params.password);
}