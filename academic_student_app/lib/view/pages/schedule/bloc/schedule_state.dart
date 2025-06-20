part of 'schedule_bloc.dart';

@immutable
sealed class ScheduleState {
  const ScheduleState();
}

final class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<SessionCourse> courses;
  const ScheduleLoaded({required this.courses});
}
