import 'package:academic_student/core/providers/registered_courses_bloc/registered_courses_bloc.dart';
import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/view/pages/home/widgets/registered_course_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeRegisteredCourses extends StatefulWidget {
  const HomeRegisteredCourses({super.key});

  @override
  State<HomeRegisteredCourses> createState() => _HomeRegisteredCoursesState();
}

class _HomeRegisteredCoursesState extends State<HomeRegisteredCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("registered_course".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<RegisteredCoursesBloc, RegisteredCoursesState>(
          builder: (context, state) {
            if (state is RegisteredCoursesLoading) {
              return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => SizedBox(
                        height: 100,
                        child: Shimmer.fromColors(
                            direction: ShimmerDirection.ttb,
                            baseColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xFF303030)
                                    : const Color(0xFFEFEFEF),
                            highlightColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xFF505050)
                                    : const Color.fromARGB(255, 224, 223, 223),
                            child: Container(
                              width: double.infinity,
                              height: 15,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                            )),
                      ));
            } else if (state is TogglingFavoriteCourse) {
              return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 50),
                  itemCount: state.registeredCourses.length,
                  itemBuilder: (context, index) => RegisteredCourseWidget(
                        isLoading: state.loadingCourse ==
                            state.registeredCourses[index],
                        course: state.registeredCourses[index],
                      ));
            } else if (state is RegisteredCoursesLoaded) {
              return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 50),
                  itemCount: state.registeredCourses.length,
                  itemBuilder: (context, index) => AnimatedSlide(
                        offset: Offset.zero,
                        duration: Duration(milliseconds: 300 + (index * 100)),
                        child: RegisteredCourseWidget(
                          course: state.registeredCourses[index],
                        ),
                      ));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
