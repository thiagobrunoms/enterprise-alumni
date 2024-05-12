import 'package:flutter_test_template/common/api/api_management.dart';
import 'package:flutter_test_template/profile/data/models/profile.dart';

Future<Profile> cmGetProfile() async => await api.profile.getProfile();
