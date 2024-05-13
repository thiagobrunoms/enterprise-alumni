import 'package:flutter_test_template/auth/presentation/vw_login.dart';
import 'package:go_router/go_router.dart';

GoRoute authenticationRoute = GoRoute(
  path: '/sign-in',
  builder: (_, __) => const VwLogin(),
);
