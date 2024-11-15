import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView(
      {super.key,
      required this.emailForgotPasswordCallback,
      required this.cancelRequestCallback});
  final Future<String?> Function({required String email})
      emailForgotPasswordCallback;
  final void Function() cancelRequestCallback;

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();

  String? email;
  String? errorMessage;
  CrossFadeState crossFadeState = CrossFadeState.showFirst;

  @override
  void initState() {
    emailController.text = "";
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
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          errorMessage = await widget
                              .emailForgotPasswordCallback(email: email!);
                          if (errorMessage != null) {
                            setState(() {
                              emailController.clear();
                              crossFadeState = CrossFadeState.showSecond;
                            });
                          } else {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Password Reset"),
                                    content: Text(
                                      "Please check your email for a password reseet link."
                                      " Once you set a new password, you can login in the Sign In screen.",
                                    ),
                                    actions: [
                                      FilledButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                        }
                      },
                      child: Text("Password Reset")),
                ),
                Row(
                  children: [
                    Text("Changed your mind?"),
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: widget.cancelRequestCallback,
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
    super.dispose();
  }
}
