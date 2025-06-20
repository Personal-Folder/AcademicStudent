import 'package:academic_student/view/pages/home/widgets/home_more_button.dart';
import 'package:flutter/material.dart';

class HomeComponentWidget extends StatelessWidget {
  final String route;
  final Widget headWidget;
  final List<Widget> children;

  const HomeComponentWidget({
    super.key,
    required this.route,
    required this.children,
    required this.headWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          headWidget,
          ...children,
          if (route.isNotEmpty) HomeMoreButton(route: route),
        ],
      ),
    );
  }
}
