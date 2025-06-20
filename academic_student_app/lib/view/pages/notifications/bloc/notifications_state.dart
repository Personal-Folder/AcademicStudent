part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsState {
  const NotificationsState();
}

final class NotificationsInitial extends NotificationsState {
  final List<AppNotification> todayNotifications;
  final List<AppNotification> yesterdayNotifications;
  final List<AppNotification> laterNotifications;
  const NotificationsInitial(
      {required this.todayNotifications,
      required this.laterNotifications,
      required this.yesterdayNotifications});
}

class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();
}
