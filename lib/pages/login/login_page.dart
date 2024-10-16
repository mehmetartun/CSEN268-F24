import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/login_cubit.dart';
import 'views/error_view.dart';
import 'views/initial_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()..init(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoginError:
              return ErrorView();
            case LoginInitial:
            default:
              return InitialView();
          }
        },
      ),
    );
  }
}
