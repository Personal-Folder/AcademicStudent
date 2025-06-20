import 'package:academic_student/core/models/notification.dart';
import 'package:academic_student/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({required this.notification, super.key});
  final AppNotification notification;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF303030)
          : getRandomColor(),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(12),
          child: Icon(
            Icons.calculate_rounded,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        title: Text(
          notification.title ?? "",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        subtitle: notification.body != null
            ? Text(
                notification.body ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              )
            : null,
      ),
    );
  }
}
