import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

enum NotificationType {
  onMessage,
  onBackgroundMessage,
  onMessageOpenedApp,
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial()) {
    on<NotificationsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<NotificationsOnMessageEvent>((event, emit) {
      emit(NotificationsReceivedState(
          message: event.message,
          notificationType: NotificationType.onMessage));
    });
    on<NotificationsOnMessageOpenedAppEvent>((event, emit) {
      emit(NotificationsReceivedState(
          message: event.message,
          notificationType: NotificationType.onMessageOpenedApp));
    });
    on<NotificationsOnBackgroundMessageEvent>((event, emit) {
      emit(NotificationsReceivedState(
          message: event.message,
          notificationType: NotificationType.onBackgroundMessage));
    });
  }

  StreamSubscription<RemoteMessage>? messageSubscription;

  StreamSubscription<RemoteMessage>? messageOpenedAppSubscription;

  void init() async {
    messageOpenedAppSubscription =
        FirebaseMessaging.onMessageOpenedApp.listen((message) {});

    messageSubscription = FirebaseMessaging.onMessage.listen((message) {
      print("message");
      add(NotificationsOnMessageEvent(message: message));
    });

    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      add(NotificationsOnBackgroundMessageEvent(message: message));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    messageSubscription?.cancel();
    messageOpenedAppSubscription?.cancel();
    return super.close();
  }
}
