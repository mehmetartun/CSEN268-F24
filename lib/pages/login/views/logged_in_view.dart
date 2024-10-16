import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/user_card.dart';
import '../cubit/login_cubit.dart';

class LoggedInView extends StatelessWidget {
  const LoggedInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: UserCard(
                  user: BlocProvider.of<LoginCubit>(context).user!,
                ),
              ),
              SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  BlocProvider.of<LoginCubit>(context).reset();
                },
                child: Text("Reset"),
              ),
              FilledButton(
                onPressed: () {
                  BlocProvider.of<LoginCubit>(context).error();
                },
                child: Text("Trigger Error"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
