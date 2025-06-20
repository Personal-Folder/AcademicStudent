// ignore_for_file: depend_on_referenced_packages

import 'package:academic_student/core/models/session_course.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../utils/helpers/dialogs.dart';
import '../../../services/session_courses_service.dart';

part 'session_course_state.dart';

class SessionCourseCubit extends Cubit<SessionCourseState> {
  SessionCourseCubit() : super(SessionCourseInitial());

  Future getSessionCourses() async {
    emit(SessionCourseLoading());

    await SessionCoursesService().getSessionCourses().then((result) {
      result.fold(
        (listResult) {
          emit(
            SessionCourseLoaded(
              sessionCourses: sessionCoursesFromListMap(
                listResult[1],
              ),
            ),
          );
        },
        (stringResult) {
          CustomDialogs().errorDialog(message: stringResult);
        },
      );
    }).catchError((e) {});
  }
}
