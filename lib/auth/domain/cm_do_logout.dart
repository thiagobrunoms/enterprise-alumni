import 'package:flutter_test_template/common/api/api_management.dart';
import 'package:flutter_test_template/common/router/router.dart';

class NoParam {}

Future<bool> cmDoLogout(NoParam noParam) async {
  var response = await api.authentication.logout();

  if (response) {
    goRouter.go('/sign-in');
  }

  return response;
}
