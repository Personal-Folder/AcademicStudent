import 'package:academic_student/core/models/nav_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar(
      {required this.selectedIndex, required this.onChange, super.key});
  final Function(int) onChange;
  final int selectedIndex;
  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final List<SMIBool> _riveIconInputs = [];
  final List<StateMachineController?> _controlers = [];
  int _selectedNavIndex = 0;
  @override
  void didUpdateWidget(covariant CustomBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _selectedNavIndex = widget.selectedIndex;
    }
  }

  @override
  void initState() {
    _selectedNavIndex = widget.selectedIndex;
    super.initState();
  }

  void _animateTheIcon(int index) {
    _riveIconInputs[index].change(true);
    Future.delayed(const Duration(seconds: 1), () {
      _riveIconInputs[index].change(false);
    });
  }

  void _riveOnInit(Artboard artboard, {required String stateMachineName}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    artboard.addController(controller!);
    _controlers.add(controller);
    _riveIconInputs.add(controller.findInput<bool>("active") as SMIBool);
  }

  @override
  void dispose() {
    for (StateMachineController? controler in _controlers) {
      controler?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return BottomAppBar(
    //     shape: CircularNotchedRectangle(),
    //     color: Theme.of(context).colorScheme.secondary,
    //     child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: List.generate(bottomNavItems.length, (index) {
    //           final riveIcon = bottomNavItems[index].rive;
    //           return GestureDetector(
    //             onTap: () {
    //               _animateTheIcon(index);
    //               setState(() {
    //                 _selectedNavIndex = index;
    //               });
    //               widget.onChange(index);
    //             },
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 // AnimatedBar(
    //                 //   isActive: _selectedNavIndex == index,
    //                 // ),
    //                 SizedBox(
    //                   height: 36,
    //                   width: 36,
    //                   child: Opacity(
    //                     opacity: _selectedNavIndex == index ? 1 : 0.5,
    //                     child: RiveAnimation.asset(
    //                       riveIcon.src,
    //                       artboard: riveIcon.artboard,
    //                       onInit: (artboard) {
    //                         _riveOnInit(artboard,
    //                             stateMachineName: riveIcon.stateMachineName);
    //                       },
    //                     ),
    //                   ),
    //                 ),
    //                 Text(
    //                   bottomNavItems[index].title.tr,
    //                   style: Theme.of(context).textTheme.titleSmall?.copyWith(
    //                       color: _selectedNavIndex == index
    //                           ? Colors.white
    //                           : Colors.grey),
    //                 )
    //               ],
    //             ),
    //           );
    //         })));
    return Container(
      height: 80,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        // boxShadow: const [BoxShadow(offset: Offset(0, 20), blurRadius: 20)]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(bottomNavItems.length, (index) {
          final riveIcon = bottomNavItems[index].rive;
          return GestureDetector(
            onTap: () {
              _animateTheIcon(index);
              setState(() {
                _selectedNavIndex = index;
              });
              widget.onChange(index);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // AnimatedBar(
                //   isActive: _selectedNavIndex == index,
                // ),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: Opacity(
                    opacity: _selectedNavIndex == index ? 1 : 0.5,
                    child: RiveAnimation.asset(
                      riveIcon.src,
                      artboard: riveIcon.artboard,
                      onInit: (artboard) {
                        _riveOnInit(artboard,
                            stateMachineName: riveIcon.stateMachineName);
                      },
                    ),
                  ),
                ),
                Text(
                  bottomNavItems[index].title.tr,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: _selectedNavIndex == index
                          ? Colors.white
                          : Colors.grey),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({super.key, required this.isActive});
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: BoxDecoration(
          color: const Color(0xFF81B4FF),
          borderRadius: BorderRadius.circular(12)),
    );
  }
}
