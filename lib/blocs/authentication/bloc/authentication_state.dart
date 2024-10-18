part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoggedIn extends AuthenticationState {}

final class AuthenticationLoggedOut extends AuthenticationState {}
