part of 'registered_courses_bloc.dart';

@immutable
sealed class RegisteredCoursesState {
  const RegisteredCoursesState();
}

final class RegisteredCoursesLoading extends RegisteredCoursesState {}

class RegisteredCoursesLoaded extends RegisteredCoursesState {
  final List<RegisteredCourse> registeredCourses;
  final bool? isFirstTime;
  const RegisteredCoursesLoaded(
      {required this.registeredCourses, this.isFirstTime = false});
}

class TogglingFavoriteCourse extends RegisteredCoursesState {
  final List<RegisteredCourse> registeredCourses;
  final RegisteredCourse loadingCourse;
  const TogglingFavoriteCourse(
      {required this.registeredCourses, required this.loadingCourse});
}
