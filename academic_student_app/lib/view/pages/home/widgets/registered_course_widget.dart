import 'package:academic_student/core/models/registered_course.dart';
import 'package:academic_student/core/providers/registered_courses_bloc/registered_courses_bloc.dart';
import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/view/pages/sessionCourseDetail/screen/session_course_detail.dart';
import 'package:academic_student/view/pages/sessionMaterialDetail/screen/session_material_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisteredCourseWidget extends StatelessWidget {
  const RegisteredCourseWidget(
      {required this.course,
      this.showFavorite = true,
      this.isLoading,
      super.key});
  final RegisteredCourse course;
  final bool? isLoading;
  final bool? showFavorite;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (course.type == 'material') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SessionMaterialDetail(
                      sessionMaterialId: course.id ?? -1)));
        }
        if (course.type == 'course') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SessionCourseDetail(course: course)));
        }
      },
      child: Card(
        child: ListTile(
          leading: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: getRandomColor(),
              borderRadius: BorderRadius.circular(10),
            ),
            width: 40,
            height: 40,
            child: Center(
              child: Text(
                (course.name ?? "").trim()[0],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
          title: Text(
            course.name ?? "",
          ),
          titleTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface),
          subtitle: Text(
            course.code ?? "",
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          trailing: showFavorite!
              ? (isLoading ?? false)
                  ? const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : IconButton(
                      icon: course.isFavorite!
                          ? const Icon(Icons.star_rounded)
                          : const Icon(Icons.star_border_rounded),
                      onPressed: () {
                        context
                            .read<RegisteredCoursesBloc>()
                            .add(ToggleFavorite(course: course));
                      },
                    )
              : const SizedBox(),
        ),
      ),
    );
  }
}
