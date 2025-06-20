import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_design.dart';
import '../../../../utils/painter/button_gradiant.dart';

class MaterialCourseJoinButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const MaterialCourseJoinButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      width: 120,
      height: 20,
      child: CustomPaint(
        painter: ButtonGradiantPaint(
          strokeWidth: 0.5,
          radius: 50,
          gradient: const LinearGradient(
            colors: [pink, aqua],
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [aqua, pink],
            ),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.white,
              width: 0.1,
            ),
          ),
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: FittedBox(
              child: Text(
                title.tr,
                textAlign: TextAlign.center,
                style: textLargeButtonStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
