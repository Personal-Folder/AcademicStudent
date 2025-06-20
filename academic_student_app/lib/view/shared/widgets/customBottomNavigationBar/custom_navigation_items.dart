import 'package:academic_student/core/providers/user_bloc/bloc/user_bloc.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../../core/models/custom_bottom_navigation_bar_item.dart';

class CustomNavigationItems {
  CustomBottomNavigationBarItem logoutNavigationItem() {
    return CustomBottomNavigationBarItem(
      icon: Icons.logout,
      onPressed: () {
        navigator!.context.read<UserBloc>().add(UserLogout());
      },
    );
  }

  CustomBottomNavigationBarItem homeNavigationItem() {
    return CustomBottomNavigationBarItem(
      icon: Icons.home,
      onPressed: () {
        Navigator.of(navigator!.context).pushNamedAndRemoveUntil(
          homeScreenRoute,
          ModalRoute.withName('/home'),
          arguments: true,
        );
      },
    );
  }

  CustomBottomNavigationBarItem notificationNavigationItem() {
    return CustomBottomNavigationBarItem(
      icon: Icons.notifications,
      onPressed: () {},
    );
  }

  CustomBottomNavigationBarItem folderNavigationItem() {
    return CustomBottomNavigationBarItem(
      icon: Icons.person,
      onPressed: () {
        Navigator.of(navigator!.context).pushNamed(profileScreenRoute);
      },
    );
  }
}
