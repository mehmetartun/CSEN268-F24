import 'package:CSEN268_F24/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouterDemoLogin extends StatelessWidget {
  const RouterDemoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: Center(
          child: Column(
            children: [
              Text("Router Demo Login"),
              FilledButton(
                child: Text("Login"),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(AuthenticationLoginEvent());
                },
              )
            ],
          ),
        ));
  }
}
