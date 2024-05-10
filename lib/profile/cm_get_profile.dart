import 'package:flutter_test_template/utils/ut_dummy_json_api/md_profile.dart';
import 'package:flutter_test_template/utils/ut_dummy_json_api/ut_dummy_json_api.dart';

Future<MdProfile> cmGetProfile() async {
  return await utJsonDummyApi.profile();
}