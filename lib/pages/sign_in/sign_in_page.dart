import 'package:CSEN268_F24/pages/sign_in/cubit/sign_in_cubit.dart';
import 'package:CSEN268_F24/pages/sign_in/views/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignInCubit cubit = SignInCubit();

    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<SignInCubit, SignInState>(
        builder: (context, state) {
          switch (state) {
            case SignInInitial _:
            default:
              return SignInView(emailSignInCallback: cubit.emailSignIn);
          }
        },
      ),
    );
  }
}
