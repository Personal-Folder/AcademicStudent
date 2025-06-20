import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_design.dart';

class HomeHeadline extends StatelessWidget {
  final String title;
  const HomeHeadline({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: FittedBox(
        child: Text(
          title.tr,
          textAlign: TextAlign.center,
          style: textHomeHeadLineStyle,
        ),
      ),
    );
  }
}
