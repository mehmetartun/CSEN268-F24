import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login_cubit.dart';

class InitialView extends StatelessWidget {
  const InitialView({super.key});

  @override
  Widget build(BuildContext context) {
    final String text = BlocProvider.of<LoginCubit>(context).className;

    return Scaffold(
      appBar: AppBar(title: Text("Hello Login")),
      body: Center(
          child: Column(
        children: [
          FilledButton(
            onPressed: () {
              BlocProvider.of<LoginCubit>(context).printSomething();
            },
            child: Text("Press here"),
          ),
          Text(text),
        ],
      )),
    );
  }
}
