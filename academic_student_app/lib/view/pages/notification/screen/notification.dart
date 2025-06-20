import 'package:academic_student/core/providers/social_media_groups_cubit/cubit/social_media_groups_cubit.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/view/pages/home/widgets/whatsapp_group_home_widget.dart';
import 'package:academic_student/view/shared/widgets/custom_scaffold_widget.dart';
import 'package:academic_student/view/shared/widgets/no_data_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/constants/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // context.read<MajorCubit>().getMajors(section.id.toString());
    return CustomScaffold(
      backHome: true,
      redirect: false,
      title: 'whatsapp'.tr,
      body: RefreshIndicator(
        onRefresh: () async {
          // context.read<MajorCubit>().getMajors(section.id.toString());
        },
        child: BlocBuilder<SocialMediaGroupsCubit, SocialMediaGroupsState>(
          builder: (context, state) {
            if (state is SocialMediaGroupsLoaded) {
              if (state.socialMediaGroups.isEmpty) {
                return const NoListDataWidget();
              }
              return GridView.count(
                crossAxisCount: displayWidth(context) ~/ 200,
                childAspectRatio: 1,
                mainAxisSpacing: 15,
                crossAxisSpacing: 20,
                padding: const EdgeInsets.all(35),
                children: state.socialMediaGroups
                    .map(
                      (whatsappGroup) => WhatsappWidget(
                        whatsappGroup: whatsappGroup,
                      ),
                    )
                    .toList(),
              );
            }
            return GridView.count(
              padding: const EdgeInsets.all(35),
              crossAxisCount: displayWidth(context) ~/ 200,
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
    );
  }
}
