import 'package:flutter_test_template/utils/ut_dummy_json_api/ut_dummy_json_api.dart';

Future<bool> cmDeleteProduct(int id) async =>
    await utJsonDummyApi.doDeleteProduct(id);
