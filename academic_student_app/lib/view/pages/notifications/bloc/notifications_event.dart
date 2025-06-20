part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsEvent {
  const NotificationsEvent();
}

class GetNotifications extends NotificationsEvent {
  const GetNotifications();
}
