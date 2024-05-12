import 'package:flutter_test_template/common/api/api_management.dart';
import 'package:flutter_test_template/common/api/http_client.dart';
import 'package:flutter_test_template/products/data/models/product.dart';

Future<(BasicApiFailure?, ProductsList?)> cmGetProducts() async => await api.products.getProducts();
