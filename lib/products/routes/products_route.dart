import 'package:go_router/go_router.dart';
import '../presentation/vw_products.dart';

GoRoute productsRoute = GoRoute(
  path: '/products',
  builder: (_, __) => const VwProducts(),
);
