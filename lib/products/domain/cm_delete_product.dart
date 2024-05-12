import 'package:flutter_test_template/common/api/api_management.dart';
import 'package:flutter_test_template/common/api/http_client.dart';

Future<(BasicApiFailure?, bool?)> cmDeleteProduct(int productId) async => await api.products.deleteProduct(productId);
