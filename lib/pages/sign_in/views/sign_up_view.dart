import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView(
      {super.key,
      required this.emailSignUpCallback,
      required this.signInRequestCallback});
  final Future<String?> Function(
      {required String email, required String password}) emailSignUpCallback;
  final void Function() signInRequestCallback;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;
  String? errorMessage;
  CrossFadeState crossFadeState = CrossFadeState.showFirst;

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
        title: Text("Sign Up"),
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
                AnimatedCrossFade(
                    firstChild: Container(),
                    secondChild: Text(errorMessage ?? "Error",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.error)),
                    crossFadeState: crossFadeState,
                    duration: Duration(milliseconds: 300)),
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
                    password = passwordController.text;
                  },
                  validator: (value) => null,
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 10),
                  child: FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          errorMessage = await widget.emailSignUpCallback(
                              email: email!, password: password!);
                          if (errorMessage != null) {
                            setState(() {
                              emailController.clear();
                              passwordController.clear();
                              crossFadeState = CrossFadeState.showSecond;
                            });
                          }
                        }
                      },
                      child: Text("Sign Up")),
                ),
                Row(
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      child: Text("Sign In"),
                      onPressed: widget.signInRequestCallback,
                    )
                  ],
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
