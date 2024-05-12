import 'package:flutter_test_template/common/api/api_management.dart';

Future<bool> cmDeleteProduct(int productId) async => await api.products.deleteProduct(productId);
