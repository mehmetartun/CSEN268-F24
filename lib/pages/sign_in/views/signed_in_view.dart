import 'package:CSEN268_F24/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:CSEN268_F24/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignedInView extends StatelessWidget {
  const SignedInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: UserCard(
                  user: BlocProvider.of<SignInBloc>(context).user!,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  BlocProvider.of<SignInBloc>(context).add(SignInResetEvent());
                },
                child: const Text("Reset"),
              ),
              FilledButton(
                onPressed: () {
                  BlocProvider.of<SignInBloc>(context)
                      .add(SignInErrorEvent(errorText: "An Error Occurred"));
                },
                child: const Text("Trigger Error"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
