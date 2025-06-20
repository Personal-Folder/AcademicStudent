import 'package:academic_student/view/pages/home/widgets/home_component_widget.dart';
import 'package:academic_student/view/pages/home/widgets/home_shimmer_headline.dart';
import 'package:academic_student/view/pages/home/widgets/home_shimmer_widget.dart';
import 'package:flutter/material.dart';

class HomeShimmerComponentWidget extends StatelessWidget {
  const HomeShimmerComponentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return HomeComponentWidget(
      headWidget: const HomeShimmerHeadline(),
      route: '',
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              3,
              (index) => const HomeShimmerWidget(),
            ),
          ),
        ),
      ],
    );
  }
}
