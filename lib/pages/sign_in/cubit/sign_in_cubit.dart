import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Future<String?> emailSignIn(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(SignInSuccess());

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        return 'Wrong password provided for that user.';
      } else {
        return e.code;
      }
    } catch (e) {
      return e.toString();
    }
  }

  void signUpRequest() {
    emit(SignUpState());
  }

  void signInRequest() {
    emit(SignInInitial());
  }

  void resetPasswordRequest() {
    emit(PasswordReset());
  }

  Future<String?> forgotPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      emit(SignInInitial());
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.code;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> emailSignUp(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SignInSuccess());
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.code;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
