part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsReceivedState extends NotificationsState {
  final RemoteMessage message;
  final NotificationType notificationType;

  NotificationsReceivedState({
    required this.message,
    required this.notificationType,
  });
}
