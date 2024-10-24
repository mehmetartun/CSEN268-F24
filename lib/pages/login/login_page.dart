import 'package:CSEN268_F24/pages/login/views/logged_in_view.dart';
import 'package:CSEN268_F24/repositories/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/login_cubit.dart';
import 'views/error_view.dart';
import 'views/initial_view.dart';
import 'views/waiting_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
          RepositoryProvider.of<AuthenticationRepository>(context))
        ..init(), //We are passing the AuthenticationRepository into the cubit
      // Remember: Cubit doesn't have access to the context! Without access to
      // the context it cannot reach the repository through RepositoryProvider.of<>
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          switch (state) {
            case LoginError _:
              return ErrorView(errorText: (state as LoginError).errorText);
            case LoginWaiting _:
              return WaitingView();
            case LoggedIn _:
              return LoggedInView();

            case LoginInitial _:
            default:
              return InitialView();
          }
        },
      ),
    );
  }
}
