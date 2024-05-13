import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test_template/common/api/api_management.dart';
import 'package:flutter_test_template/common/router/page_not_found.dart';
import 'package:flutter_test_template/common/router/routes.dart';
import 'package:go_router/go_router.dart';

final rootNavigationKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: rootNavigationKey,
  initialLocation: '/sign-in',
  errorBuilder: (_, __) => const PageNotFound(),
  routes: routes(),
  redirect: (context, state) async {
    bool isLogged = await api.authentication.isLoggedIn();
    if (isLogged) {
      if (state.fullPath == '/sign-in') {
        return '/products';
      }

      return null;
    }

    return '/sign-in';
  },
);
