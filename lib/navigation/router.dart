import 'package:CSEN268_F24/utilities/stream_to_listenable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../pages/generic_page.dart';

class MyRoutes {
  static final signIn = MyRoute(name: "signIn", path: "/sign_in");
  static final home = MyRoute(name: "home", path: "/");
}

class MyRoute {
  final String name;
  final String path;

  MyRoute({required this.name, required this.path});
}

final GoRouter router = GoRouter(
  refreshListenable:
      StreamToListenable([FirebaseAuth.instance.authStateChanges()]),
  redirect: (context, state) {
    if (FirebaseAuth.instance.currentUser == null &&
        !(state.fullPath?.startsWith("/sign_in") ?? false)) {
      return "/sign_in";
    }
    return null;
  },
  initialLocation: "/",
  routes: [
    GoRoute(
      path: MyRoutes.home.path,
      name: MyRoutes.home.name,
      builder: (context, state) => GenericPage(title: "Home"),
    ),
    GoRoute(
      path: MyRoutes.signIn.path,
      name: MyRoutes.signIn.name,
      builder: (context, state) => GenericPage(title: "Sign In"),
    ),
  ],
);
