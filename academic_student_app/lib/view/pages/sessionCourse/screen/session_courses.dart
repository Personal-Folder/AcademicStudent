import 'package:academic_student/core/providers/session_course_cubit/cubit/session_course_cubit.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/view/shared/widgets/custom_scaffold_widget.dart';
import 'package:academic_student/view/shared/widgets/no_data_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../utils/routes/routes.dart';
import '../widgets/session_course_widget.dart';

class SessionCoursesScreen extends StatelessWidget {
  const SessionCoursesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<SessionCourseCubit>().getSessionCourses();
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(homeScreenRoute, ModalRoute.withName('/home'));
        return true;
      },
      child: CustomScaffold(
        title: 'courses'.tr,
        backHome: true,
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<SessionCourseCubit>().getSessionCourses();
          },
          child: Center(
            child: Container(
              width: websiteSize,
              alignment: Alignment.topCenter,
              child: BlocBuilder<SessionCourseCubit, SessionCourseState>(
                builder: (context, state) {
                  if (state is SessionCourseLoaded) {
                    if (state.sessionCourses.isEmpty) {
                      return const NoListDataWidget();
                    }
                    return ListView(
                      children: state.sessionCourses
                          .map(
                            (e) => SessionCourseWidget(sessionCourse: e),
                          )
                          .toList(),
                    );
                  }
                  return ListView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    children: const [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
