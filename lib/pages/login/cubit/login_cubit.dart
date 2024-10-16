import 'package:CSEN268_F24/repositories/authentication/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authenticationRepository) : super(LoginInitial());
  User? user;

  final AuthenticationRepository authenticationRepository;

  void init() async {}

  void reset() {
    user == null;
    emit(LoginInitial());
  }

  void error() {
    emit(LoginError(errorText: "Some unknown error."));
  }

  void loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginWaiting());
    user =
        await authenticationRepository.signIn(email: email, password: password);
    emit(LoggedIn());
  }
}
