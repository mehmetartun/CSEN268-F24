import 'package:flutter/material.dart';

class GenericPage extends StatelessWidget {
  const GenericPage({super.key, required this.title, this.child});
  final String title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: child ?? Container(),
    );
  }
}
