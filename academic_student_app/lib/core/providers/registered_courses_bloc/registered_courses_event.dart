part of 'registered_courses_bloc.dart';

@immutable
sealed class RegisteredCoursesEvent {
  const RegisteredCoursesEvent();
}

class GetRegisteredCourses extends RegisteredCoursesEvent {
  const GetRegisteredCourses();
}

class ToggleFavorite extends RegisteredCoursesEvent {
  final RegisteredCourse course;
  const ToggleFavorite({required this.course});
}
