part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsEvent {}

class NotificationsOnMessageEvent extends NotificationsEvent {
  final RemoteMessage message;

  NotificationsOnMessageEvent({required this.message});
}

class NotificationsOnBackgroundMessageEvent extends NotificationsEvent {
  final RemoteMessage message;

  NotificationsOnBackgroundMessageEvent({required this.message});
}

class NotificationsOnMessageOpenedAppEvent extends NotificationsEvent {
  final RemoteMessage message;

  NotificationsOnMessageOpenedAppEvent({required this.message});
}
