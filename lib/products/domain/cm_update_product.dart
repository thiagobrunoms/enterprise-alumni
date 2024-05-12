import 'package:flutter_test_template/common/api/api_management.dart';
import 'package:flutter_test_template/common/api/http_client.dart';
import 'package:flutter_test_template/products/data/models/product.dart';

Future<(BasicApiFailure?, Product?)> cmUpdateProduct(Product product) async =>
    await api.products.updateProduct(product);