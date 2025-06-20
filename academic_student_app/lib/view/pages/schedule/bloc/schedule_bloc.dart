import 'package:academic_student/core/models/session_course.dart';
import 'package:academic_student/core/services/session_courses_service.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleLoading()) {
    List<SessionCourse> _courses = [];
    on<ScheduleEvent>((event, emit) {});
    on<GetShecdule>((event, emit) async {
      await SessionCoursesService().getSessionCourses().then((result) {
        result.fold(
          (listResult) {
            _courses = sessionCoursesFromListMap(
              listResult[1],
            );
            emit(
              ScheduleLoaded(courses: _courses),
            );
          },
          (stringResult) {
            CustomDialogs().errorDialog(message: stringResult);
          },
        );
      }).catchError((e) {});
    });
  }
}
