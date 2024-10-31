import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dialog Page"),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton(
            child: Text("Simple Dialog"),
            onPressed: () {},
          ),
          FilledButton(
            child: Text("Alert Dialog OK"),
            onPressed: () {},
          ),
          FilledButton(
            child: Text("Alert Dialog OK-Cancel"),
            onPressed: () {},
          ),
          FilledButton(
            child: Text("FullScreen Dialog"),
            onPressed: () {},
          ),
          FilledButton(
            child: Text("Modal Bottom Sheet"),
            onPressed: () {},
          ),
          FilledButton(
            child: Text("Persistent Bottom Sheet"),
            onPressed: () {},
          ),
          FilledButton(
            child: Text("Persistent Bottom Sheet"),
            onPressed: () {},
          ),
        ],
      )),
    );
  }
}
