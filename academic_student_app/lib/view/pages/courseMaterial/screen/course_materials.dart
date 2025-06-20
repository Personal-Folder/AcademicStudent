import 'package:academic_student/core/models/major.dart';
import 'package:academic_student/core/providers/course_material_cubit/cubit/course_material_cubit.dart';
import 'package:academic_student/view/pages/sessionMaterial/screen/session_materal.dart';
import 'package:academic_student/view/shared/widgets/leading_back_button.dart';
import 'package:academic_student/view/shared/widgets/no_data_list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic_student/core/models/section.dart';
import 'package:academic_student/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CourseMaterialsScreen extends StatefulWidget {
  final Section section;
  final Major major;
  const CourseMaterialsScreen(
      {super.key, required this.section, required this.major});

  @override
  State<CourseMaterialsScreen> createState() => _CourseMaterialsScreenState();
}

class _CourseMaterialsScreenState extends State<CourseMaterialsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<CourseMaterialCubit>()
        .getCourseMaterials(widget.major.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingBackButton(screenContext: context),
        title: Text(widget.major.title),
      ),
      body: BlocBuilder<CourseMaterialCubit, CourseMaterialState>(
        builder: (context, state) {
          if (state is CourseMaterialLoading) {
            return const LoadingState();
          } else if (state is CourseMaterialLoaded) {
            if (state.courseMaterials.isEmpty) {
              return const Center(child: NoListDataWidget());
            }
            return GridView.extent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.shortestSide < 600 ? 2 : 4),
              padding: const EdgeInsets.all(8),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: List.generate(state.courseMaterials.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SessionMaterialsScreen(
                                  courseMaterialId:
                                      state.courseMaterials[index].id,
                                  sectionId: widget.section.id ?? -1,
                                  majorId: widget.major.id,
                                )));
                  },
                  child: Card(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF303030)
                        : getRandomColor(),
                    child: Center(
                        child: Text(
                      state.courseMaterials[index].code,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface),
                    )),
                  ),
                );
              }),
            );
          }
          return const SizedBox();
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
    return GridView.extent(
      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.all(8),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: List.generate(10, (index) {
        return SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width / 2,
          child: Shimmer.fromColors(
              direction: ShimmerDirection.ttb,
              baseColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF303030)
                  : const Color(0xFFEFEFEF),
              highlightColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF505050)
                  : const Color.fromARGB(255, 224, 223, 223),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              )),
        );
      }),
    );
  }
}
