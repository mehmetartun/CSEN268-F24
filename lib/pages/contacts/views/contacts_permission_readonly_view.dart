import 'package:flutter/material.dart';

class ContactsPermissionReadOnlyView extends StatelessWidget {
  const ContactsPermissionReadOnlyView({
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
          Text("The user has only given read only permissions"),
        ],
      )),
    );
  }
}
