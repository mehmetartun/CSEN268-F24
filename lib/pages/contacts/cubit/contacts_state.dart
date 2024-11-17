part of 'contacts_cubit.dart';

@immutable
sealed class ContactsState {}

final class ContactsInitial extends ContactsState {}

final class ContactsPermissionDenied extends ContactsState {}

final class ContactsPermissionReadOnly extends ContactsState {
  final List<Contact> contacts;

  ContactsPermissionReadOnly({required this.contacts});
}

final class ContactsPermissionFullAccess extends ContactsState {
  final List<Contact> contacts;
  final void Function(Contact) editCallback;

  ContactsPermissionFullAccess({
    required this.contacts,
    required this.editCallback,
  });
}

final class ContactsWaiting extends ContactsState {
  final String message;

  ContactsWaiting({required this.message});
}

final class ContactEdit extends ContactsState {
  final Contact contact;
  final void Function(Contact) saveCallback;

  ContactEdit({required this.contact, required this.saveCallback});
}
