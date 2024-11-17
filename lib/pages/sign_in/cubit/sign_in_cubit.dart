import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<String?> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      try {
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        emit(SignInSuccess());
        return null;
      } catch (e) {
        return e.toString();
      }
    }
  }

  Future<String?> appleSignIn() async {
    final appleProvider = AppleAuthProvider();
    if (kIsWeb) {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithPopup(appleProvider);
    } else {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);
    }
    if (UserCredential != null) {
      emit(SignInSuccess());
    }
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
