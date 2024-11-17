import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:meta/meta.dart';

part 'contacts_state.dart';

enum PermissionType { unknown, none, readOnly, full }

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsInitial());
  PermissionType permissionType = PermissionType.unknown;
  List<Contact>? contacts;

  void init() async {
    if (await FlutterContacts.requestPermission()) {
      permissionType = PermissionType.full;
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withAccounts: true, withPhoto: true);
      emit(ContactsPermissionFullAccess(
          contacts: contacts!,
          editCallback: (Contact contact) {
            saveContact(contact);
          }));
      return;
    } else {
      permissionType = PermissionType.none;
      if (Platform.isAndroid) {
        if (await FlutterContacts.requestPermission(readonly: true)) {
          permissionType = PermissionType.readOnly;
          contacts = await FlutterContacts.getContacts();

          emit(ContactsPermissionReadOnly(contacts: contacts!));
          return;
        }
      } else {}
    }
    emit(ContactsPermissionDenied());
  }

  void editContact(Contact contact) {
    emit(ContactEdit(saveCallback: saveContact, contact: contact));
  }

  void saveContact(Contact contact) async {
    await FlutterContacts.updateContact(contact);
    contacts = await FlutterContacts.getContacts(
        withProperties: true, withAccounts: true, withPhoto: true);
    emit(ContactsPermissionFullAccess(
        contacts: contacts!, editCallback: editContact));
  }

  void getContacts() async {
    emit(ContactsWaiting(message: "Retrieving Contacts"));
  }
}
