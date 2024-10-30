import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial()) {
    on<NotificationsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<NotificationsTestEvent>((event, emit) {
      emit(NotificationsTestState());
    });
  }

  void init() async {
    FirebaseMessaging.onMessage.listen((message) {
      add(NotificationsTestEvent());
    });
  }
}
