// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'session_course_cubit.dart';

@immutable
abstract class SessionCourseState {}

class SessionCourseInitial extends SessionCourseState {}

class SessionCourseLoading extends SessionCourseState {}

class SessionCourseLoaded extends SessionCourseState {
  final List<SessionCourse> sessionCourses;
  SessionCourseLoaded({
    required this.sessionCourses,
  });
}
