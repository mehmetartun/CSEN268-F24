import 'package:CSEN268_F24/repositories/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/sign_in_bloc.dart';
import 'views/error_view.dart';
import 'views/initial_view.dart';
import 'views/signed_in_view.dart';
import 'views/waiting_view.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(
          RepositoryProvider.of<AuthenticationRepository>(context))
        ..init(), //We are passing the AuthenticationRepository into the cubit
      // Remember: Cubit doesn't have access to the context! Without access to
      // the context it cannot reach the repository through RepositoryProvider.of<>
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          switch (state) {
            case SignInError _:
              return ErrorView(errorText: state.errorText);
            case SignInWaiting _:
              return const WaitingView();
            case SignedIn _:
              return const SignedInView();
            case SignInInitial _:
            default:
              return const InitialView();
          }
        },
      ),
    );
  }
}
