import 'package:academic_student/core/providers/session_course_cubit/cubit/session_course_cubit.dart';
import 'package:academic_student/view/pages/courses/widgets/course_widget.dart';
import 'package:academic_student/view/shared/widgets/no_data_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  bool _visible = false;
  @override
  void initState() {
    context.read<SessionCourseCubit>().getSessionCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<SessionCourseCubit, SessionCourseState>(
        listener: (context, state) {
          if (state is SessionCourseLoaded) {
            Future.delayed(const Duration(milliseconds: 500), () {
              setState(() {
                _visible = true;
              });
            });
          }
        },
        builder: (context, state) {
          if (state is SessionCourseLoaded) {
            if (state.sessionCourses.isEmpty) {
              return const NoListDataWidget();
            }
            return ListView.builder(
              itemCount: state.sessionCourses.length,
              itemBuilder: (context, index) => AnimatedSlide(
                duration: Duration(milliseconds: 300 + (index * 100)),
                offset: _visible ? Offset.zero : const Offset(-1, 0),
                child: CourseWidget(sessionCourse: state.sessionCourses[index]),
              ),
            );
          }
          return const LoadingState();
        },
      ),
    );
  }
}

class LoadingState extends StatelessWidget {
  const LoadingState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => SizedBox(
              height: 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                      direction: ShimmerDirection.ttb,
                      baseColor: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF303030)
                      : const Color(0xFFEFEFEF),
                      highlightColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF505050)
                          : const Color.fromARGB(255, 224, 223, 223),
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Shimmer.fromColors(
                      direction: ShimmerDirection.ttb,
                      baseColor: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF303030)
                      : const Color(0xFFEFEFEF),
                      highlightColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF505050)
                          : const Color.fromARGB(255, 224, 223, 223),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 15,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ));
  }
}
