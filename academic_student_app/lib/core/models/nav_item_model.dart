import 'package:academic_student/core/models/rive_model.dart';

class NavItemModel {
  final String title;
  final RiveModel rive;
  NavItemModel({required this.rive, required this.title});
}

List<NavItemModel> bottomNavItems = [
  NavItemModel(
      rive: RiveModel(
          src: "assets/RiveAssets/icons.riv",
          artboard: "HOME",
          stateMachineName: "HOME_interactivity"),
      title: "home"),
  NavItemModel(
      rive: RiveModel(
          src: "assets/RiveAssets/icons.riv",
          artboard: "BELL",
          stateMachineName: "BELL_Interactivity"),
      title: "notifications"),
  NavItemModel(
      rive: RiveModel(
          src: "assets/RiveAssets/icons.riv",
          artboard: "LIKE/STAR",
          stateMachineName: "STAR_Interactivity"),
      title: "favorites"),
  NavItemModel(
      rive: RiveModel(
          src: "assets/RiveAssets/icons.riv",
          artboard: "USER",
          stateMachineName: "USER_Interactivity"),
      title: "profile"),
];
