import 'package:flutter/material.dart';

class RouterDemoHome extends StatelessWidget {
  const RouterDemoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home")),
        body: Center(child: Text("Router Demo Home")));
  }
}
