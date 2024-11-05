import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactEditView extends StatefulWidget {
  final Contact contact;
  final void Function(Contact) saveCallback;
  const ContactEditView(
      {super.key, required this.contact, required this.saveCallback});

  @override
  State<ContactEditView> createState() => _ContactEditViewState();
}

class _ContactEditViewState extends State<ContactEditView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late Contact _contact;

  @override
  void initState() {
    _contact = widget.contact;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("Edit Contact"),
              TextFormField(
                initialValue: _contact.name.first,
                onSaved: (val) {
                  _contact.name.first = val ?? "";
                },
                decoration: InputDecoration(labelText: "First Name"),
              ),
              TextFormField(
                initialValue: _contact.name.last,
                decoration: InputDecoration(labelText: "Last Name"),
                onSaved: (val) {
                  _contact.name.last = val ?? "";
                },
              ),
              TextFormField(
                initialValue: _contact.displayName,
                decoration: InputDecoration(labelText: "Display Name"),
                onSaved: (val) {
                  _contact.displayName = val ?? "";
                },
              ),
              SizedBox(height: 20),
              FilledButton(
                  onPressed: () {
                    _formKey.currentState?.save();
                    widget.saveCallback(_contact);
                  },
                  child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
