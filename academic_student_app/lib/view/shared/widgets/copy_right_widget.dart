import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CopyRightWidget extends StatelessWidget {
  const CopyRightWidget({
    this.color,
    super.key,
  });
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'copy_right'.tr,
          style:
              TextStyle(color: color ?? Theme.of(context).colorScheme.primary),
        ),
        Text(
          'main_website'.tr,
          style:
              TextStyle(color: color ?? Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
