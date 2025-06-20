part of 'staff_bloc.dart';

sealed class StaffState {
  const StaffState();
}

final class StaffInitial extends StaffState {}

class StaffLoaded extends StaffState {
  final List<Instructor> instructors;
  const StaffLoaded({required this.instructors});
}
