import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user.dart';
import '../repositories/authentication/authentication_repository.dart';

class StatefulLoginPage extends StatefulWidget {
  const StatefulLoginPage({super.key});

  @override
  State<StatefulLoginPage> createState() => _StatefulLoginPageState();
}

class _StatefulLoginPageState extends State<StatefulLoginPage> {
  User? user;
  late AuthenticationRepository repo;
  String? email;
  String? password;
  bool busy = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    repo = RepositoryProvider.of<AuthenticationRepository>(context);
    super.initState();
  }

  void loginUser() async {
    setState(() {
      busy = true;
    });
    user = await repo.signIn(email: email!, password: password!);
    setState(() {
      busy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repository Demo"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Authentication Status",
                  style: Theme.of(context).textTheme.labelMedium),
              Text(user == null
                  ? "Unauthenticated"
                  : "${user!.firstName} ${user!.lastName}"),
              Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                    validator: (value) {
                      // Also you can use value.trim() to avoid full of spaces...
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email = value;
                    },
                    readOnly: busy ? true : false,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      password = value;
                    },
                    readOnly: busy ? true : false,
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: busy
                        ? null
                        : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _formKey.currentState?.save();
                              loginUser();
                            }
                          },
                    child: const Text('Login'),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
