import 'package:academic_student/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.callback,
      this.color});
  final IconData icon;
  final String title;
  final Function callback;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: primaryColor,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title.tr,
            style: TextStyle(color: color),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
