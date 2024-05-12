import 'package:go_router/go_router.dart';

import '../../auth/routes/auth_route.dart';

List<GoRoute> routes() {
  return [
    authenticationRoute,
  ];
}
