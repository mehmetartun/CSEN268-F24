part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent {}

class SignInWithEmailEvent extends SignInEvent {
  final String email;
  final String password;

  SignInWithEmailEvent({required this.email, required this.password});
}

class SignInErrorEvent extends SignInEvent {
  final String errorText;

  SignInErrorEvent({required this.errorText});
}

class SignInResetEvent extends SignInEvent {}
