import 'dart:math';

import 'package:academic_student/core/models/schedule.dart';
import 'package:academic_student/core/models/session_course.dart';
import 'package:academic_student/view/pages/schedule/bloc/schedule_bloc.dart';
import 'package:academic_student/view/pages/schedule/widgets/schedule_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Random _random = Random();

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ScheduleBloc>().add(GetShecdule());
    DateTime now = DateTime.now();
    int weekday = now.weekday; // Monday is 1, Sunday is 7
    DateTime startOfWeek = now.subtract(Duration(days: weekday - 1));

    // Generate a list of 7 dates from Monday to Sunday
    List<DateTime> daysOfWeek =
        List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
    DateTime selectedDay = now;

    return Scaffold(
      appBar: AppBar(
        title: Text("schedule".tr),
      ),
      body: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ScheduleLoaded) {
            for (SessionCourse course in state.courses) {
              debugPrint("schedule of courses : ${course.schedule}");
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Card(
                      color: Theme.of(context).brightness == Brightness.light
                          ? null
                          : Theme.of(context).colorScheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0).copyWith(top: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "this_week".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? null
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            StatefulBuilder(builder: (context, setDay) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: daysOfWeek.map((date) {
                                  String dayName = DateFormat.E()
                                      .format(date)
                                      .toUpperCase(); // Get day name, e.g., Mon, Tue
                                  String dayDate = DateFormat.d()
                                      .format(date); // Format date, e.g., 10/25

                                  return InkWell(
                                    onTap: () =>
                                        setDay(() => selectedDay = date),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(dayName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 4),
                                        Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: selectedDay.day ==
                                                    date.day
                                                ? BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))
                                                : null,
                                            child: Text(
                                              dayDate,
                                              style: TextStyle(
                                                  color: selectedDay.day ==
                                                          date.day
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .surface
                                                      : null),
                                            )),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                        height:
                            20), // Space between the weekly view and time slots
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                            children: List.generate(
                          7,
                          (index) {
                            int hour = 8 + index; // Starting from 8
                            String period = hour >= 12
                                ? 'pm'
                                : 'am'; // Determine if it's am or pm
                            String formattedTime =
                                '${hour % 12 == 0 ? 12 : hour % 12}:00 $period'; // Format time
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 40.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        formattedTime,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? null
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .onSurface),
                                      )), // Time label

                                  Expanded(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        const Divider(thickness: 2),
                                        Align(
                                          alignment: getRandomAlignment(),
                                          child: SizedBox(
                                            width: 200,
                                            child: ScheduleWidget(
                                              schedule: Schedule(
                                                title: state.courses.first.name,
                                                start: createDateTime(
                                                    state.courses.first.schedule
                                                        .firstOrNull["day"],
                                                    state.courses.first.schedule
                                                            .firstOrNull[
                                                        "time_from"]),
                                                end: createDateTime(
                                                    state.courses.first.schedule
                                                        .firstOrNull["day"],
                                                    state.courses.first.schedule
                                                            .firstOrNull[
                                                        "time_to"]),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ), // Divider line
                                  ),
                                ],
                              ),
                            );
                          },
                        ).toList()),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

Alignment getRandomAlignment() {
  // List of possible alignments
  List<Alignment> alignments = [
    Alignment.centerRight,
    Alignment.centerLeft,
    Alignment.center,
  ];

  // Create a Random object

  // Get a random alignment from the list
  return alignments[_random.nextInt(alignments.length)];
}

DateTime createDateTime(String day, String time) {
  // Get today's date
  DateTime now = DateTime.now();

  // Create a map to convert day names to integers
  Map<String, int> daysOfWeek = {
    'Monday': 1,
    'Tuesday': 2,
    'Wednesday': 3,
    'Thursday': 4,
    'Friday': 5,
    'Saturday': 6,
    'Sunday': 7,
  };

  // Calculate the difference in days to get to the specified day
  int targetDay = daysOfWeek[day]!;
  int currentDay = now.weekday;
  int daysDifference = (targetDay - currentDay + 7) %
      7; // To get to the next occurrence of the day

  // Create the DateTime for the specified day with the given time
  DateTime targetDate = now.add(Duration(days: daysDifference));
  List<String> timeParts = time.split(':');
  int hours = int.parse(timeParts[0]);
  int minutes = int.parse(timeParts[1]);
  int seconds = int.parse(timeParts[2]);

  // Return the combined DateTime
  return DateTime(targetDate.year, targetDate.month, targetDate.day, hours,
      minutes, seconds);
}
