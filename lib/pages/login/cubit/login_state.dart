part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginError extends LoginState {
  final String errorText;

  LoginError({required this.errorText});
}

final class LoginWaiting extends LoginState {}

final class LoggedIn extends LoginState {}
