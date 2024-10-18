import 'package:CSEN268_F24/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouterDemoUsers extends StatelessWidget {
  const RouterDemoUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Users")),
        body: Center(
            child: Column(
          children: [
            Text("Router Demo Users"),
            FilledButton(
              child: Text("Logout"),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLogoutEvent());
              },
            )
          ],
        )));
  }
}
