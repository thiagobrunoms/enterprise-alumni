import 'package:flutter_test_template/products/routes/products_route.dart';
import 'package:go_router/go_router.dart';

import '../../auth/routes/auth_route.dart';

List<GoRoute> routes() {
  return [
    authenticationRoute,
    productsRoute,
  ];
}
