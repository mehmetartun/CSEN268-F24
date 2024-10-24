import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login/cubit/login_cubit.dart';
import '../bloc/sign_in_bloc.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.errorText});
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Text(
              "Error",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onErrorContainer),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: FilledButton(
              child: const Text("Reset"),
              onPressed: () {
                BlocProvider.of<SignInBloc>(context).add(SignInResetEvent());
              },
            ),
          )
        ],
      ),
    );
  }
}
