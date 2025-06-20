import 'package:academic_student/core/models/rive_model.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {required this.title,
      required this.rive,
      required this.press,
      required this.riveOnInit,
      required this.isActive,
      super.key});
  final String title;
  final RiveModel rive;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          height: 56,
          width: isActive ? 288 : 0,
          left: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryFixedDim,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
          ),
        ),
        ListTile(
          onTap: press,
          leading: SizedBox(
            height: 34,
            width: 34,
            child: RiveAnimation.asset(
              rive.src,
              artboard: rive.artboard,
              onInit: riveOnInit,
            ),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isActive
                    ? Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF505050)
                        : Theme.of(context).colorScheme.primary
                    : Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF505050)
                        : Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
