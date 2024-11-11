import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class FunctionsDemoPage extends StatefulWidget {
  const FunctionsDemoPage({super.key});

  @override
  State<FunctionsDemoPage> createState() => _FunctionsDemoPageState();
}

class _FunctionsDemoPageState extends State<FunctionsDemoPage> {
  final HttpsCallable helloWorld =
      FirebaseFunctions.instance.httpsCallable('helloWorld');
  String? result;

  @override
  void initState() {
    super.initState();
  }

  void callHelloWorld() async {
    HttpsCallableResult ret = await helloWorld.call();
    result = ret.data['message'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Functions Demo"),
      ),
      body: Center(
        child: Column(
          children: [
            FilledButton(
              onPressed: () {
                callHelloWorld();
              },
              child: Text("Call helloWorld"),
            ),
            Text("Result is: $result"),
          ],
        ),
      ),
    );
  }
}
