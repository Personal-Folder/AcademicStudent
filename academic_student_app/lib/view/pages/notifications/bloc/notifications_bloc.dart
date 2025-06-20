import 'dart:math' hide log;

import 'package:academic_student/core/models/notification.dart';
import 'package:academic_student/core/services/notifications_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

final random = Random();

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  List<AppNotification> _notifications = [];
  List<AppNotification> _todayNotifications = [];
  List<AppNotification> _yesterdayNotifications = [];
  List<AppNotification> _laterNotifications = [];
  NotificationsBloc() : super(const NotificationsLoading()) {
    List<AppNotification> groupNotificationsByToday() {
      final today = DateTime.now();
      return _notifications
          .where((notification) =>
              notification.date?.year == today.year &&
              notification.date?.month == today.month &&
              notification.date?.day == today.day)
          .toList();
    }

    List<AppNotification> groupNotificationsByYesterday() {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      return _notifications
          .where((notification) =>
              notification.date?.year == yesterday.year &&
              notification.date?.month == yesterday.month &&
              notification.date?.day == yesterday.day)
          .toList();
    }

    List<AppNotification> groupNotificationsByOlder() {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));
      return _notifications
          .where((notification) => (notification.date ?? DateTime.now())
              .isBefore(
                  DateTime(yesterday.year, yesterday.month, yesterday.day)))
          .toList();
    }

    on<GetNotifications>((event, emit) async {
      final Either<List<AppNotification>, String> result =
          await NotificationsService().getNotifications();
      result.fold((List<AppNotification> l) {
        _notifications = l;
      }, (String m) {});
      _todayNotifications = groupNotificationsByToday();
      _yesterdayNotifications = groupNotificationsByYesterday();
      _laterNotifications = groupNotificationsByOlder();
      emit(NotificationsInitial(
          todayNotifications: _todayNotifications,
          yesterdayNotifications: _yesterdayNotifications,
          laterNotifications: _laterNotifications));
    });
  }
}
