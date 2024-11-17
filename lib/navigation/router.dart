import 'package:go_router/go_router.dart';

import '../pages/generic_page.dart';

final GoRouter router = GoRouter(initialLocation: "/", routes: [
  GoRoute(
    path: "/",
    name: "home",
    builder: (context, state) => GenericPage(title: "Home"),
  ),
]);
