import 'package:flutter_test_template/utils/ut_dummy_json_api/md_product.dart';
import 'package:flutter_test_template/utils/ut_dummy_json_api/ut_dummy_json_api.dart';

Future<ProductsList> cmGetProducts() async => await utJsonDummyApi.products();
