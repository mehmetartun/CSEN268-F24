import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final String className = "CSEN 268";

  void init() async {
    await Future.delayed(Duration(seconds: 5), () {});
    error();
  }

  void error() {
    emit(LoginError());
  }

  void printSomething() {
    print("Something");
  }
}
