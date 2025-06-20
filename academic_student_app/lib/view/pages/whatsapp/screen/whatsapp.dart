
import 'package:academic_student/core/providers/social_media_groups_cubit/cubit/social_media_groups_cubit.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/view/pages/whatsapp/widgets/whatsapp_widget.dart';
import 'package:academic_student/view/shared/widgets/custom_scaffold_widget.dart';
import 'package:academic_student/view/shared/widgets/no_data_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/constants/colors.dart';

class WhatsappScreen extends StatelessWidget {
  const WhatsappScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<SocialMediaGroupsCubit>().getSocialMediaGroups();
    return CustomScaffold(
      backHome: true,
      redirect: false,
      title: 'whatsapp'.tr,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<SocialMediaGroupsCubit>().getSocialMediaGroups();
        },
        child: Center(
          child: SizedBox(
            width: websiteSize,
            child: BlocBuilder<SocialMediaGroupsCubit, SocialMediaGroupsState>(
              builder: (context, state) {
                if (state is SocialMediaGroupsLoaded) {
                  if (state.socialMediaGroups.isEmpty) {
                    return const NoListDataWidget();
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (displayWidth(context) >= websiteSize ? websiteSize : displayWidth(context)) ~/ 125,
                      childAspectRatio: 1,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 5,
                    ),
                    itemCount: state.socialMediaGroups.length,
                    padding: const EdgeInsets.all(35),
                    itemBuilder: (context, index) => WhatsappGroupListWidget(
                      whatsappGroup: state.socialMediaGroups[index],
                    ),
                  );
                }
                return GridView.count(
                  crossAxisCount: (displayWidth(context) >= websiteSize ? websiteSize : displayWidth(context)) ~/ 125,
                  childAspectRatio: 1,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 5,
                  padding: const EdgeInsets.all(35),
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
