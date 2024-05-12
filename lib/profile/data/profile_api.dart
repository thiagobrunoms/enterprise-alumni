import 'package:flutter_test_template/common/api/http_client.dart';
import 'package:flutter_test_template/profile/data/models/profile.dart';

abstract class ProfileApi {
  Future<(BasicApiFailure?, Profile?)> getProfile();
}
