import 'package:flutter/material.dart';

import '../../../../core/models/custom_bottom_navigation_bar_item.dart';
import '../../../../utils/constants/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final List<CustomBottomNavigationBarItem> items;
  const CustomBottomNavigationBar({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map(
                (item) => IconButton(
                  onPressed: () => item.onPressed(),
                  icon: Icon(
                    item.icon,
                    color: white,
                    size: 30,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
