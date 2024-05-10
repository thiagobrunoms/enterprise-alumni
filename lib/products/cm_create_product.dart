import 'package:flutter_test_template/utils/ut_dummy_json_api/md_product.dart';
import 'package:flutter_test_template/utils/ut_dummy_json_api/ut_dummy_json_api.dart';

class CmCreateProductParams {
  final String title;
  final int price;

  CmCreateProductParams({required this.title, required this.price});
}

Future<Product> cmCreateProduct(CmCreateProductParams product) async =>
    await utJsonDummyApi.doCreateProduct(product);
