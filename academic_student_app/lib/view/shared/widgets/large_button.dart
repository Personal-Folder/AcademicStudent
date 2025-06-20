import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';

class LargeButton extends StatelessWidget {
  final String? title;
  final double? minWidth;
  final double? maxHeight;
  final bool showBackground;
  final EdgeInsetsGeometry? padding;

  final Function() onPressed;
  final TextStyle textStyle;
  const LargeButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.textStyle,
    this.showBackground = true,
    this.minWidth,
    this.maxHeight,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: showBackground ? primaryColor : Colors.transparent),
      width: minWidth ?? 100,
      height: maxHeight ?? 50,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(50),
              side: showBackground
                  ? BorderSide.none
                  : const BorderSide(color: primaryColor)),
          visualDensity: const VisualDensity(
            vertical: VisualDensity.minimumDensity,
          ),
        ),
        child: Center(
          child: Padding(
            padding: padding ??
                const EdgeInsets.symmetric(
                  // vertical: 2,
                  horizontal: 25,
                ),
            child: title != null
                ? Text(
                    title!.tr,
                    textAlign: TextAlign.center,
                    style: textStyle.copyWith(
                        color: showBackground ? Colors.white : primaryColor),
                  )
                : const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
