import 'package:flutter_test_template/profile/data/models/profile.dart';

abstract class ProfileApi {
  Future<Profile> getProfile();
}
