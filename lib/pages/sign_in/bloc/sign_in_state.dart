part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInError extends SignInState {
  final String errorText;

  SignInError({required this.errorText});
}

final class SignInWaiting extends SignInState {}

final class SignedIn extends SignInState {}
