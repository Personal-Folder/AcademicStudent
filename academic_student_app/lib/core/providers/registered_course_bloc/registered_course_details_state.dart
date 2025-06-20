part of 'registered_course_details_bloc.dart';

@immutable
sealed class RegisteredCourseDetailsState {
  const RegisteredCourseDetailsState();
}

final class RegisteredCourseDetailsInitial
    extends RegisteredCourseDetailsState {}

final class RegisteredCourseDetailsLoading
    extends RegisteredCourseDetailsState {
  const RegisteredCourseDetailsLoading();
}

final class RegisteredCourseDetailsLoaded extends RegisteredCourseDetailsState {
  final RegisteredCourseDetails details;
  const RegisteredCourseDetailsLoaded({required this.details});
}

final class RegisteredCourseDetailsError extends RegisteredCourseDetailsState {
  const RegisteredCourseDetailsError();
}
