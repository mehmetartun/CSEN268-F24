import 'package:flutter/material.dart';

class ContactsWaitingView extends StatelessWidget {
  final String message;
  const ContactsWaitingView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Center(
          child: Column(
        children: [
          Text(message),
          CircularProgressIndicator(),
        ],
      )),
    );
  }
}
