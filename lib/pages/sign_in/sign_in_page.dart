import 'package:CSEN268_F24/navigation/router.dart';
import 'package:CSEN268_F24/pages/sign_in/cubit/sign_in_cubit.dart';
import 'package:CSEN268_F24/pages/sign_in/views/forgot_pasword_view.dart';
import 'package:CSEN268_F24/pages/sign_in/views/sign_in_view.dart';
import 'package:CSEN268_F24/pages/sign_in/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignInCubit cubit = SignInCubit();

    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            GoRouter.of(context).goNamed(MyRoutes.home.name);
          }
        },
        builder: (context, state) {
          switch (state) {
            case PasswordReset _:
              return ForgotPasswordView(
                emailForgotPasswordCallback: cubit.forgotPassword,
                cancelRequestCallback: cubit.signInRequest,
              );
            case SignUpState _:
              return SignUpView(
                emailSignUpCallback: cubit.emailSignUp,
                signInRequestCallback: cubit.signInRequest,
              );
            case SignInInitial _:
            default:
              return SignInView(
                emailSignInCallback: cubit.emailSignIn,
                signUpRequestCallback: cubit.signUpRequest,
                resetPasswordRequestCallback: cubit.resetPasswordRequest,
                googleSignInCallback: cubit.googleSignIn,
              );
          }
        },
      ),
    );
  }
}
