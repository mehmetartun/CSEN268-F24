import 'package:CSEN268_F24/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:CSEN268_F24/pages/home_page.dart';
import 'package:CSEN268_F24/pages/login/login_page.dart';
import 'package:CSEN268_F24/pages/router_demo_pages/router_demo_home.dart';
import 'package:CSEN268_F24/pages/router_demo_pages/router_demo_login.dart';
import 'package:CSEN268_F24/pages/router_demo_pages/router_demo_profile.dart';
import 'package:CSEN268_F24/pages/router_demo_pages/router_demo_profile_detail.dart';
import 'package:CSEN268_F24/pages/router_demo_pages/router_demo_users.dart';
import 'package:CSEN268_F24/pages/sign_in/sign_in_page.dart';
import 'package:CSEN268_F24/pages/stateful_login_page.dart';
import 'package:CSEN268_F24/utilities/stream_to_listenable.dart';
import 'package:CSEN268_F24/widgets/scaffold_with_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouteName {
  static const home = "home";
  static const login = "login";
  static const profile = "profile";
  static const profileDetail = "profileDetail";
  static const users = "users";
  static const editprofile = "editprofile";
  static const adduser = "adduser";
}

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "Root");
final GlobalKey<NavigatorState> shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "Shell");

GoRouter routerDemo(AuthenticationBloc authenticationBloc) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/users',
    refreshListenable: StreamToListenable([authenticationBloc.stream]),
    redirect: (context, state) async {
      if (authenticationBloc.state is AuthenticationLoggedOut &&
          (!(state.fullPath?.startsWith("/login") ?? false))) {
        return "/login";
      } else {
        if ((state.fullPath?.startsWith("/login") ?? false) &&
            authenticationBloc.state is AuthenticationLoggedIn) {
          return "/users";
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: RouteName.login,
        builder: (context, state) {
          return const RouterDemoLogin();
        },
      ),
      GoRoute(
          path: '/',
          name: RouteName.home,
          builder: (context, state) {
            return const RouterDemoHome();
          },
          routes: [
            ShellRoute(
              navigatorKey: shellNavigatorKey,
              builder:
                  (BuildContext context, GoRouterState state, Widget child) {
                return ScaffoldWithNavBar(child: child);
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'users',
                  name: RouteName.users,
                  builder: (BuildContext context, GoRouterState state) {
                    return const RouterDemoUsers();
                  },
                ),
                GoRoute(
                    path: 'profile',
                    name: RouteName.profile,
                    builder: (BuildContext context, GoRouterState state) {
                      return const RouterDemoProfile();
                    },
                    routes: [
                      GoRoute(
                        path: 'detail',
                        name: RouteName.profileDetail,
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (BuildContext context, GoRouterState state) {
                          return const RouterDemoProfileDetail();
                        },
                      )
                    ]),
              ],
            )
          ]),
    ],
  );
}
