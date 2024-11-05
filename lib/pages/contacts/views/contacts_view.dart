import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsView extends StatelessWidget {
  final List<Contact> contacts;
  final void Function(Contact)? editContactCallback;
  final bool readOnly;
  const ContactsView({
    super.key,
    required this.contacts,
    required this.readOnly,
    this.editContactCallback,
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
          Text(readOnly ? "Read Only Mode" : "Full Access Mode"),
          Expanded(
            child: ListView(
              children: contacts.map((contact) {
                return ListTile(
                  title: Text(contact.displayName),
                  trailing: readOnly
                      ? null
                      : IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: editContactCallback == null
                              ? null
                              : () {
                                  editContactCallback!(contact);
                                },
                        ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
