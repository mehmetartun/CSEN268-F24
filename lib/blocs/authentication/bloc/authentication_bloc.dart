import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AuthenticationLoginEvent>((event, emit) {
      _login(event, emit);
    });
    on<AuthenticationLogoutEvent>((event, emit) {
      _logout(event, emit);
    });
  }

  void _login(event, emit) {
    emit(AuthenticationLoggedIn());
  }

  void _logout(event, emit) {
    emit(AuthenticationLoggedOut());
  }
}
