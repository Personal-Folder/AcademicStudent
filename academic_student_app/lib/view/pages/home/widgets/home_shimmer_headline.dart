import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/constants/colors.dart';

class HomeShimmerHeadline extends StatelessWidget {
  const HomeShimmerHeadline({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighlightColor,
      child: Container(
        height: 35,
        width: 250,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
