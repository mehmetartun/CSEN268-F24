import 'package:CSEN268_F24/pages/sign_in/sign_in_page.dart';
import 'package:CSEN268_F24/utilities/stream_to_listenable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      builder: (context, state) => GenericPage(
          title: "Home",
          child: Center(
              child: FilledButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    await GoogleSignIn().signOut();
                  },
                  child: Text("Sign Out")))),
    ),
    GoRoute(
      path: MyRoutes.signIn.path,
      name: MyRoutes.signIn.name,
      builder: (context, state) => SignInPage(),
    ),
  ],
);

