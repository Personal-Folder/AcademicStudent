part of 'registered_course_details_bloc.dart';

@immutable
sealed class RegisteredCourseDetailsEvent {
  const RegisteredCourseDetailsEvent();
}

final class GetRegisteredCourseDetails extends RegisteredCourseDetailsEvent {
  final int courseId;
  const GetRegisteredCourseDetails({required this.courseId});
}
