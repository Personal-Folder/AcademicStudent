import 'package:academic_student/core/models/nav_item_model.dart';
import 'package:academic_student/core/models/rive_model.dart';
import 'package:academic_student/view/pages/drawer/widgets/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen(
      {required this.selectedIndex, required this.onChange, super.key});
  final Function(int) onChange;
  final int selectedIndex;
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final List<NavItemModel> _items = bottomNavItems;
  RiveModel _selectedItem = bottomNavItems.first.rive;

  @override
  void didUpdateWidget(covariant DrawerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _selectedItem = bottomNavItems[widget.selectedIndex].rive;
    }
  }

  @override
  void initState() {
    _selectedItem = bottomNavItems[widget.selectedIndex].rive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50),
      color: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF303030)
          : Theme.of(context).colorScheme.primary,
      width: 288,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: _items
              .map((e) => DrawerItem(
                    title: e.title.tr,
                    rive: e.rive,
                    isActive: _selectedItem == e.rive,
                    riveOnInit: (artboard) {
                      StateMachineController? controller =
                          StateMachineController.fromArtboard(
                              artboard, e.rive.stateMachineName);
                      artboard.addController(controller!);
                      e.rive.status = controller.findSMI("active") as SMIBool;
                    },
                    press: () {
                      e.rive.status?.change(true);
                      Future.delayed(const Duration(milliseconds: 250), () {
                        e.rive.status?.change(false);
                      });
                      setState(() {
                        _selectedItem = e.rive;
                      });
                      Future.delayed(const Duration(milliseconds: 500), () {
                        widget.onChange(_items.indexOf(e));
                      });
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}
