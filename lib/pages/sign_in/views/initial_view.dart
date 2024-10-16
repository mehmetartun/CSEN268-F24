import 'package:CSEN268_F24/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialView extends StatefulWidget {
  const InitialView({super.key});

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  final _formKey = GlobalKey<FormState>();
  late SignInBloc bloc;
  String? email;
  String? password;
  @override
  void initState() {
    // TODO: implement initState
    bloc = BlocProvider.of<SignInBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Authentication Status",
                style: Theme.of(context).textTheme.labelMedium),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Email",
                      ),
                      validator: (value) {
                        // Also you can use value.trim() to avoid full of spaces...
                        if (value == null ||
                            value.isEmpty ||
                            value.trim() == "") {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Password",
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim() == "") {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.maxFinite,
                      child: FilledButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            bloc.add(SignInWithEmailEvent(
                                email: email!, password: password!));
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
