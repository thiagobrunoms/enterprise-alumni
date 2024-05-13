import 'package:flutter_test_template/profile/presentation/vw_profile.dart';
import 'package:go_router/go_router.dart';

GoRoute profileRoute = GoRoute(
  path: '/profile',
  builder: (_, __) => const VwProfile(),
);
