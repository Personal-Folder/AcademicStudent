import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class CustomHomeDivider extends StatelessWidget {
  const CustomHomeDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 10,
      ),
      height: 5,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(90),
      ),
    );
  }
}
