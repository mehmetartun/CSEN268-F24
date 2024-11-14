import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key, required this.emailSignInCallback});
  final void Function({required String email, required String password})
      emailSignInCallback;

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? email;
  String? password;

  @override
  void initState() {
    emailController.text = "";
    passwordController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10)),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  onSaved: (newValue) {
                    email = emailController.text;
                  },
                  validator: (value) => null,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  onSaved: (newValue) {
                    email = passwordController.text;
                  },
                  validator: (value) => null,
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 10),
                  child: FilledButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                        }
                      },
                      child: Text("Sign In")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
