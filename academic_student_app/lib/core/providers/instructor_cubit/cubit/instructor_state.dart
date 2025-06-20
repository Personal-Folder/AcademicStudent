// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'instructor_cubit.dart';

@immutable
abstract class InstructorState {}

class InstructorInitial extends InstructorState {}

class InstructorLoading extends InstructorState {}

class InstructorLoaded extends InstructorState {
  final List<Instructor> instructors;
  InstructorLoaded({
    required this.instructors,
  });
}
