import 'package:academic_student/core/providers/registered_courses_bloc/registered_courses_bloc.dart';
import 'package:academic_student/core/providers/sections_cubit/cubit/sections_cubit.dart';
import 'package:academic_student/view/pages/home/widgets/registered_course_widget.dart';
import 'package:academic_student/view/pages/sections/widgets/section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _sectionsVisible = false;
  @override
  void initState() {
    context.read<SectionsCubit>().getSections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("favorites".tr),
        automaticallyImplyLeading: false,
      ),
      body: CustomScrollView(
        slivers: [
          BlocBuilder<RegisteredCoursesBloc, RegisteredCoursesState>(
            builder: (context, state) {
              if (state is RegisteredCoursesLoading) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => SizedBox(
                              height: 100,
                              child: Shimmer.fromColors(
                                  direction: ShimmerDirection.ttb,
                                  baseColor: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? const Color(0xFF303030)
                                      : const Color(0xFFEFEFEF),
                                  highlightColor:
                                      const Color.fromARGB(255, 224, 223, 223),
                                  child: Container(
                                    width: double.infinity,
                                    height: 15,
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  )),
                            ),
                        childCount: 5));
              } else if (state is RegisteredCoursesLoaded) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => AnimatedSlide(
                              offset: Offset.zero,
                              duration:
                                  Duration(milliseconds: 300 + (index * 100)),
                              child: RegisteredCourseWidget(
                                course: state.registeredCourses
                                    .where((e) => e.isFavorite ?? false)
                                    .toList()[index],
                                showFavorite: false,
                              ),
                            ),
                        childCount: state.registeredCourses
                            .where((e) => e.isFavorite ?? false)
                            .toList()
                            .length));
              }
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          BlocConsumer<SectionsCubit, SectionsState>(
            listener: (context, state) {
              if (MediaQuery.of(context).size.shortestSide > 600) {
                return;
              }
              if (state is SectionsLoaded) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    _sectionsVisible = true;
                  });
                });
              }
            },
            builder: (context, state) {
              return state is SectionsLoaded
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                      return AnimatedSlide(
                          offset: MediaQuery.of(context).size.shortestSide > 600
                              ? Offset.zero
                              : _sectionsVisible
                                  ? Offset.zero
                                  : const Offset(-1, 0),
                          duration: Duration(milliseconds: 300 + (index * 100)),
                          child: SectionWidget(
                            section: state.sections
                                .where((e) => e.isFavorite ?? false)
                                .toList()[index],
                            showButton: false,
                          ));
                    },
                          childCount: state.sections
                              .where((e) => e.isFavorite ?? false)
                              .toList()
                              .length))
                  : state is SectionsLoading
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => SizedBox(
                                    height: 100,
                                    child: Shimmer.fromColors(
                                        direction: ShimmerDirection.ttb,
                                        baseColor:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? const Color(0xFF303030)
                                                : const Color(0xFFEFEFEF),
                                        highlightColor: const Color.fromARGB(
                                            255, 224, 223, 223),
                                        child: Container(
                                          width: double.infinity,
                                          height: 15,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        )),
                                  ),
                              childCount: 5))
                      : const SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()),
                        );
            },
          ),
        ],
      ),
    );
  }
}
