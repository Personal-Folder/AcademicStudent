import 'package:academic_student/utils/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../core/models/custom_bottom_navigation_bar_item.dart';
import 'app_bar_widget.dart';
import 'customBottomNavigationBar/custom_bottom_navigation_bar_widget.dart';
import 'customBottomNavigationBar/custom_navigation_items.dart';
import 'custom_drawer.dart';

class CustomScaffold extends StatelessWidget {
  final String title;

  final bool? backHome;
  final bool? redirect;
  final bool? pop;
  final String? redirectUrl;
  final Object? arguments;
  final List<CustomBottomNavigationBarItem>? items;

  final Widget body;
  const CustomScaffold({
    super.key,
    required this.title,
    this.backHome,
    this.redirect,
    this.redirectUrl,
    this.arguments,
    required this.body,
    this.items,
    this.pop,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (backHome ?? false) {
          Navigator.of(context).pushNamedAndRemoveUntil(homeScreenRoute, ModalRoute.withName('/home'));
        } else if (redirectUrl != null && (redirect ?? false)) {
          Navigator.of(context).pushReplacementNamed(redirectUrl!, arguments: arguments);
        } else if (pop ?? false) {
          Navigator.of(context).pop();
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBarWidget(
          title: title,
          arguments: arguments,
          backHome: backHome,
          redirect: redirect,
          redirectUrl: redirectUrl,
          pop: pop ?? false,
        ),
        drawer: const CustomDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(
          items: items ??
              <CustomBottomNavigationBarItem>[
                CustomNavigationItems().homeNavigationItem(),
                CustomNavigationItems().folderNavigationItem(),
              ],
        ),
        body: body,
      ),
    );
  }
}
