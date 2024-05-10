import 'package:flutter/material.dart';
import 'package:flutter_test_template/utils/ut_dummy_json_api/md_product.dart';

class WdProduct extends StatelessWidget {
  const WdProduct({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Text(product.title!);
  }
}
