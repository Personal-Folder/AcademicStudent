import 'package:flutter/material.dart';

class LeadingBackButton extends StatelessWidget {
  const LeadingBackButton({required this.screenContext, super.key});
  final BuildContext screenContext;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(screenContext),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), border: Border.all()),
        child: const Center(
          child: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
    );
  }
}
