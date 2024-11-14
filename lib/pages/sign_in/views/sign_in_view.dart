import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignInView extends StatefulWidget {
  const SignInView({
    super.key,
    required this.emailSignInCallback,
    required this.signUpRequestCallback,
    required this.resetPasswordRequestCallback,
    required this.googleSignInCallback,
  });
  final Future<String?> Function(
      {required String email, required String password}) emailSignInCallback;
  final Future<String?> Function() googleSignInCallback;
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedCrossFade(
                  firstChild: Container(),
                  secondChild: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(errorMessage ?? "Error",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onErrorContainer)),
                  ),
                  crossFadeState: crossFadeState,
                  duration: Duration(milliseconds: 300)),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(10)),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: double.maxFinite,
                        child: SignInButton(
                          Buttons.google,
                          onPressed: () async {
                            errorMessage = await widget.googleSignInCallback();
                            if (errorMessage != null) {
                              setState(() {});
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                        )),
                    Container(
                        width: double.maxFinite,
                        child: SignInButton(
                          Buttons.apple,
                          onPressed: widget.googleSignInCallback,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                        )),
                  ],
                ),
              ),
              Container(
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
            ],
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
