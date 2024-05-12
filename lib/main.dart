import 'package:flutter/material.dart';
import 'package:flutter_test_template/app.dart';
import 'package:flutter_test_template/common/api/api_management.dart';

void main() async {
  await api.setup();

  runApp(const App());
}
