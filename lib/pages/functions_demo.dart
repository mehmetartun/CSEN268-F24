import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class FunctionsDemoPage extends StatefulWidget {
  const FunctionsDemoPage({super.key});

  @override
  State<FunctionsDemoPage> createState() => _FunctionsDemoPageState();
}

class _FunctionsDemoPageState extends State<FunctionsDemoPage> {
  final HttpsCallable helloWorld =
      FirebaseFunctions.instance.httpsCallable('misc-helloWorld');
  final HttpsCallable addData =
      FirebaseFunctions.instance.httpsCallable('db-addData');
  final HttpsCallable getData =
      FirebaseFunctions.instance.httpsCallable('db-getData');
  String? path;

  @override
  void initState() {
    super.initState();
  }

  void snack(String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  void callHelloWorld() async {
    HttpsCallableResult ret = await helloWorld.call();
    snack(ret.data['message']);
  }

  void callAddData() async {
    HttpsCallableResult ret = await addData.call({
      'collection': 'users_test',
      'map': {'name': 'John Doe', 'id': 123}
    });
    path = ret.data['path'];
    snack("path: ${ret.data['path']} id: ${ret.data['id']}");
  }

  void callGetData() async {
    HttpsCallableResult ret = await getData.call({'path': path});
    snack("name: ${ret.data['name']}   id: ${ret.data['id']}");
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
            FilledButton(
              onPressed: () {
                callAddData();
              },
              child: Text("Call addData (user)"),
            ),
            FilledButton(
              onPressed: () {
                callGetData();
              },
              child: Text("Call getData (path of user)"),
            ),
          ],
        ),
      ),
    );
  }
}
