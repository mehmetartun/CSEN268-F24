import 'package:CSEN268_F24/navigation/router.dart';
import 'package:CSEN268_F24/pages/home_page.dart';
import 'package:CSEN268_F24/pages/sign_in/sign_in_page.dart';
import 'package:CSEN268_F24/pages/stateful_login_page.dart';
import 'package:CSEN268_F24/repositories/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation/navigator_route.dart';
import 'pages/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) {
        return (OktaAuthenticationRepository() as AuthenticationRepository);
      },
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
      // MaterialApp(
      //     title: 'Flutter Demo',
      //     theme: ThemeData(
      //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //       useMaterial3: true,
      //     ),
      //     initialRoute: NavigatorRoute.home,
      //     routes: {
      //       NavigatorRoute.home: (context) => const HomePage(),
      //       NavigatorRoute.noBloc: (context) => const StatefulLoginPage(),
      //       NavigatorRoute.bloc: (context) => const SignInPage(),
      //       NavigatorRoute.cubit: (context) => const LoginPage(),
      //     }),
    );
  }
}
