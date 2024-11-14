part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignUpState extends SignInState {}

final class SignInSuccess extends SignInState {}
