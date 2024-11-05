import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsView extends StatelessWidget {
  final List<Contact> contacts;
  final bool readOnly;
  const ContactsView({
    super.key,
    required this.contacts,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Column(
        children: [
          Text("Here are the contacts"),
          Expanded(
            child: ListView(
              children: contacts.map((contact) {
                return ListTile(title: Text(contact.displayName));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
