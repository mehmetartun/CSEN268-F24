import 'package:CSEN268_F24/pages/contacts/cubit/contacts_cubit.dart';
import 'package:CSEN268_F24/pages/contacts/views/contact_edit_view.dart';
import 'package:CSEN268_F24/pages/contacts/views/contacts_permission_denied_view.dart';
import 'package:CSEN268_F24/pages/contacts/views/contacts_view.dart';
import 'package:CSEN268_F24/pages/contacts/views/contacts_waiting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactsCubit cubit = ContactsCubit();
    return BlocProvider(
      create: (context) => cubit..init(),
      child: BlocBuilder<ContactsCubit, ContactsState>(
        builder: (context, state) {
          switch (state) {
            case ContactsInitial _:
              return ContactsWaitingView(message: "Retrieving permissions");
            case ContactsWaiting _:
              return ContactsWaitingView(message: state.message);
            case ContactsPermissionDenied _:
              return ContactsPermissionDeniedView();
            case ContactsPermissionReadOnly _:
              return ContactsView(contacts: state.contacts, readOnly: true);
            case ContactsPermissionFullAccess _:
              return ContactsView(
                contacts: state.contacts,
                readOnly: false,
                editContactCallback: cubit.editContact,
              );
            case ContactEdit _:
              return ContactEditView(
                  contact: state.contact, saveCallback: state.saveCallback);
          }
        },
      ),
    );
  }
}
