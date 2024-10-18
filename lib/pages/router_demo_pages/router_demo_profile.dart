import 'package:CSEN268_F24/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:CSEN268_F24/navigation/routerdemo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouterDemoProfile extends StatelessWidget {
  const RouterDemoProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: Column(
          children: [
            Text("Router Demo Profile"),
            FilledButton(
              child: Text("Logout"),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLogoutEvent());
              },
            ),
            SizedBox(height: 20),
            FilledButton(
              child: Text("Show Detail"),
              onPressed: () {
                context.goNamed(RouteName.profileDetail);
              },
            )
          ],
        ),
      ),
    );
  }
}
