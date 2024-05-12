import 'package:flutter/widgets.dart';
import 'package:flutter_test_template/utils/router/routes.dart';
import 'package:go_router/go_router.dart';

final rootNavigationKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: rootNavigationKey,
  initialLocation: '/authentication',
  routes: routes(),
);
