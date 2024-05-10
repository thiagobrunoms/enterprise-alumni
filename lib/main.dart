import 'package:flutter/material.dart';
import 'package:flutter_test_template/app.dart';
import 'package:flutter_test_template/utils/ut_dummy_json_api/ut_dummy_json_api.dart';

void main() async {
  await utJsonDummyApi.setup();
  runApp(const App());
}