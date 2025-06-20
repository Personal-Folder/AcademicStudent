import 'package:academic_student/core/providers/sections_cubit/cubit/sections_cubit.dart';
import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/view/shared/widgets/custom_scaffold_widget.dart';
import 'package:academic_student/view/shared/widgets/no_data_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/section_widget.dart';

class SectionScreen extends StatelessWidget {
  const SectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backHome: true,
      title: 'sections'.tr,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<SectionsCubit>().getSections();
        },
        child: Center(
          child: Container(
            width: websiteSize,
            alignment: Alignment.topCenter,
            child: BlocBuilder<SectionsCubit, SectionsState>(
              builder: (context, state) {
                if (state is SectionsLoaded) {
                  if (state.sections.isEmpty) {
                    return const NoListDataWidget();
                  }
                  return GridView.count(
                    padding: const EdgeInsets.all(35),
                    crossAxisCount: (displayWidth(context) ~/ 200).clamp(2, 4),
                    childAspectRatio: 1,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 20,
                    children: state.sections
                        .map(
                          (section) => SectionWidget(
                            section: section,
                          ),
                        )
                        .toList(),
                  );
                }
                return GridView.count(
                  padding: const EdgeInsets.all(35),
                  crossAxisCount: (displayWidth(context) ~/ 200).clamp(2, 4),
                  childAspectRatio: 1,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 20,
                  children: List.generate(
                    6,
                    (index) => Shimmer.fromColors(
                      baseColor: shimmerBaseColor,
                      highlightColor: shimmerHighlightColor,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const SizedBox(
                          height: 85,
                          width: 85,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
