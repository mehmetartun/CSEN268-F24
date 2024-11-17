import 'package:flutter/material.dart';

class ContactsPermissionDeniedView extends StatelessWidget {
  const ContactsPermissionDeniedView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Center(
          child: Column(
        children: [
          Text("The user has not given permission to access contacts"),
        ],
      )),
    );
  }
}
