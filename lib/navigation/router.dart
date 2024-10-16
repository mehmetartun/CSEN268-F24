import 'package:CSEN268_F24/pages/home_page.dart';
import 'package:CSEN268_F24/pages/login/login_page.dart';
import 'package:CSEN268_F24/pages/sign_in/sign_in_page.dart';
import 'package:CSEN268_F24/pages/stateful_login_page.dart';
import 'package:go_router/go_router.dart';

class RouteName {
  static const home = "home";
  static const bloc = "bloc";
  static const cubit = "cubit";
  static const noBloc = "noBloc";
}

final router = GoRouter(routes: [
  GoRoute(
      name: RouteName.home,
      path: '/',
      builder: (context, state) {
        return const HomePage();
      },
      routes: [
        GoRoute(
            name: RouteName.bloc,
            path: 'bloc',
            builder: (context, state) {
              return const SignInPage();
            }),
        GoRoute(
            name: RouteName.cubit,
            path: 'cubit',
            builder: (context, state) {
              return const LoginPage();
            }),
        GoRoute(
            name: RouteName.noBloc,
            path: 'noBloc',
            builder: (context, state) {
              return const StatefulLoginPage();
            }),
      ]),
]);
