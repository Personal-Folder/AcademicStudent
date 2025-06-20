import 'package:academic_student/utils/constants/text_design.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/painter/button_gradiant.dart';

class LocalizationButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const LocalizationButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 100,
          maxHeight: 40,
        ),
        child: CustomPaint(
          painter: ButtonGradiantPaint(
            strokeWidth: 2,
            radius: 10,
            gradient: const LinearGradient(
              colors: [pink, aqua],
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [aqua, pink],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 15,
              ),
              child: Text(
                title,
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
