import 'package:CSEN268_F24/repositories/authentication/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/user.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this.authenticationRepository) : super(SignInInitial()) {
    on<SignInEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SignInWithEmailEvent>((event, emit) {
      loginUser(email: event.email, password: event.password);
    });
    on<SignInErrorEvent>((event, emit) {
      error(event, emit);
    });
    on<SignInResetEvent>((event, emit) {
      reset(event, emit);
    });
  }
  final AuthenticationRepository authenticationRepository;
  User? user;

  void init() async {}

  void reset(event, emit) {
    user == null;
    emit(SignInInitial());
  }

  void error(event, emit) {
    emit(SignInError(errorText: event.errorText));
  }

  void loginUser({
    required String email,
    required String password,
  }) async {
    emit(SignInWaiting());
    user =
        await authenticationRepository.signIn(email: email, password: password);
    emit(SignedIn());
  }
}
