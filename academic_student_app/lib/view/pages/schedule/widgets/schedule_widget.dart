import 'package:academic_student/core/models/schedule.dart';
import 'package:academic_student/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DateFormat _timeFormat = DateFormat.jm();

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({required this.schedule, super.key});
  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getRandomColor(),
      child: ListTile(
        title: Text(
          schedule.title,
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? null
                  : Theme.of(context).colorScheme.onPrimary),
        ),
        subtitle: Text(
          "${_timeFormat.format(schedule.start)} - ${_timeFormat.format(schedule.end)}",
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? null
                  : Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
