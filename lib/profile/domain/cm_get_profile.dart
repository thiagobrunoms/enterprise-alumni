import 'package:flutter_test_template/common/api/api_management.dart';
import 'package:flutter_test_template/common/api/http_client.dart';
import 'package:flutter_test_template/profile/data/models/profile.dart';

Future<(BasicApiFailure?, Profile?)> cmGetProfile() async {
  return await api.profile.getProfile();
}
