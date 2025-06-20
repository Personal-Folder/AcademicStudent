import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoListDataWidget extends StatelessWidget {
  const NoListDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/no_data_list.png',
        ),
        Center(
          child: Text('no_data_yet'.tr,
              style: Theme.of(context).textTheme.titleLarge),
        ),
      ],
    );
  }
}
