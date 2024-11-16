import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView(
      {super.key,
      required this.emailSignInCallback,
      required this.signUpRequestCallback,
      required this.resetPasswordRequestCallback});

  final Future<String?> Function(
      {required String email, required String password}) emailSignInCallback;
  final void Function() signUpRequestCallback;
  final void Function() resetPasswordRequestCallback;

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
                Row(
                  children: [
                    Text("Forgot password?"),
                    TextButton(
                      child: Text("Reset Password"),
                      onPressed: widget.resetPasswordRequestCallback,
                    )
                  ],
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 20, bottom: 0),
                  child: FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          errorMessage = await widget.emailSignInCallback(
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
                      child: Text("Sign In")),
                ),
                Row(
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      child: Text("Sign Up"),
                      onPressed: widget.signUpRequestCallback,
                    )
                  ],
                ),
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