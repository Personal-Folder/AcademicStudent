import 'package:academic_student/utils/constants/text_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';

class HomeMoreButton extends StatelessWidget {
  final String route;
  const HomeMoreButton({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 50,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(route);
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 1,
          ),
        ),
        child: FittedBox(
          child: Text(
            'more'.tr,
            textAlign: TextAlign.center,
            style: textHomeMoreButtonStyle,
          ),
        ),
      ),
    );
  }
}
