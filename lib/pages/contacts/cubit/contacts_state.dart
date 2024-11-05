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

  ContactsPermissionFullAccess({required this.contacts});
}

final class ContactsWaiting extends ContactsState {
  final String message;

  ContactsWaiting({required this.message});
}
