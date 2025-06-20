import 'package:academic_student/core/models/registered_course_details.dart';
import 'package:academic_student/core/services/session_courses_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'registered_course_details_event.dart';
part 'registered_course_details_state.dart';

class RegisteredCourseDetailsBloc
    extends Bloc<RegisteredCourseDetailsEvent, RegisteredCourseDetailsState> {
  RegisteredCourseDetails? _details;
  RegisteredCourseDetailsBloc()
      : super(const RegisteredCourseDetailsLoading()) {
    on<GetRegisteredCourseDetails>((event, emit) async {
      await SessionCoursesService()
          .showSessionCourse(event.courseId)
          .then((result) {
        result.fold(
          (listResult) {
            _details = listResult;
            emit(RegisteredCourseDetailsLoaded(
                details: _details ??
                    const RegisteredCourseDetails(
                        attachments: [], isSubscribe: false, videos: [])));
            // if (listResult[0] == 'success') {
            //   sessionCourse = SessionCourse.fromMap(listResult[1]['details']);
            //   isSubscribe = listResult[1]['is_subscribe'];
            //   subscriptionTypes = subscriptionTypesFromMapList(
            //       listResult[1]['subscription_types']);
            //   videoEnrollments = videovideoEnrollmentFromMapList(
            //       listResult[1]['enrollment']['videos']);
            //   attachmentEnrollments = attachmentEnrollmentFromMapList(
            //       listResult[1]['enrollment']['attachments']);
            //   copyRights = listResult[1]['copy_rights'];
            // }
          },
          (stringResult) {
            emit(const RegisteredCourseDetailsError());
          },
        );
      });
    });
  }
}
