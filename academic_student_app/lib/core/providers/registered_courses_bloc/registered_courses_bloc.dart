import 'package:academic_student/core/models/registered_course.dart';
import 'package:academic_student/core/services/authentication_service.dart';
import 'package:academic_student/core/services/course_materials_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'registered_courses_event.dart';
part 'registered_courses_state.dart';

class RegisteredCoursesBloc
    extends Bloc<RegisteredCoursesEvent, RegisteredCoursesState> {
  List<RegisteredCourse> _registeredCourses = [];
  RegisteredCoursesBloc() : super(RegisteredCoursesLoading()) {
    on<GetRegisteredCourses>((event, emit) async {
      await AuthenticationService().getEnrollements().then((result) {
        result.fold(
          (listResult) {
            _registeredCourses = listResult;
            emit(RegisteredCoursesLoaded(
                registeredCourses: _registeredCourses, isFirstTime: true));
          },
          (stringResult) =>
              emit(const RegisteredCoursesLoaded(registeredCourses: [])),
        );
      });
    });
    on<ToggleFavorite>((event, emit) async {
      try {
        emit(TogglingFavoriteCourse(
            registeredCourses: _registeredCourses,
            loadingCourse: event.course));
        final Either<void, String> result = await CourseMaterialService()
            .toggleCourseFavorite(event.course.courseId ?? -1);
        result.fold((v) {
          int index = _registeredCourses.indexOf(event.course);
          _registeredCourses[index] = _registeredCourses[index]
              .copyWith(isFavorite: !_registeredCourses[index].isFavorite!);
          emit(RegisteredCoursesLoaded(registeredCourses: _registeredCourses));
        }, (String m) {
          emit(RegisteredCoursesLoaded(registeredCourses: _registeredCourses));
        });
      } catch (e) {
        debugPrint("e : $e");
      }
    });
  }
}
