import 'dart:async';
import 'dart:math' hide log;

import 'package:academic_student/core/providers/footer_cubit/cubit/footer_cubit.dart';
import 'package:academic_student/core/providers/i18n/localization_provider.dart';
import 'package:academic_student/core/providers/registered_courses_bloc/registered_courses_bloc.dart';
import 'package:academic_student/core/providers/sections_cubit/cubit/sections_cubit.dart';
import 'package:academic_student/core/providers/user_bloc/bloc/user_bloc.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:academic_student/view/pages/drawer/screen/drawer_screen.dart';
import 'package:academic_student/view/pages/favorites/favorites_screen.dart';
import 'package:academic_student/view/pages/groups_sections_files/groups_sections_files_screen.dart';
import 'package:academic_student/view/pages/home/widgets/home_carousal.dart';
import 'package:academic_student/view/pages/home/widgets/home_registered_courses.dart';
import 'package:academic_student/view/pages/home/widgets/social_media_icon.dart';
import 'package:academic_student/view/pages/notifications/notifications_screen.dart';
import 'package:academic_student/view/pages/profile/screen/profile.dart';
import 'package:academic_student/view/pages/sections/widgets/section_widget.dart';
import 'package:academic_student/view/shared/widgets/bottom_navigation_bar.dart';
import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as RiveImport;
import 'package:shimmer/shimmer.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeScreen extends StatefulWidget {
  final bool refresh;
  const HomeScreen({super.key, required this.refresh});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool _isSideMenueClosed = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    context.read<RegisteredCoursesBloc>().add(const GetRegisteredCourses());
    super.initState();
  }

  int _currentIndex = 0;
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer t = Timer(
        const Duration(
          seconds: 10,
        ), () {
      Navigator.of(context).pushReplacementNamed(loginScreenRoute);
    });

    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserInitial) {
          Navigator.of(context).pushReplacementNamed(loginScreenRoute);

          t.cancel();
        }
      },
      builder: (context, userState) {
        if (userState is UserLoading) {
          return ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) => SizedBox(
                    height: 100,
                    child: Shimmer.fromColors(
                        direction: ShimmerDirection.ttb,
                        baseColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? const Color(0xFF303030)
                                : const Color(0xFFEFEFEF),
                        highlightColor:
                            const Color.fromARGB(255, 224, 223, 223),
                        child: Container(
                          width: double.infinity,
                          height: 15,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                        )),
                  ));
        } else if (userState is UserLoaded) {
          t.cancel();
          return PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: Stack(
                children: [
                  if (MediaQuery.of(context).size.shortestSide < 600)
                    AnimatedPositioned(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.fastOutSlowIn,
                        left: _isSideMenueClosed ? -288 : 0,
                        height: MediaQuery.of(context).size.height,
                        child: DrawerScreen(
                          selectedIndex: _currentIndex,
                          onChange: (int indexSelected) {
                            setState(() {
                              _currentIndex = indexSelected;
                              _animationController.reverse();
                            });
                          },
                        )),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(
                          _animation.value - 30 * _animation.value * pi / 180),
                    child: Transform.translate(
                      offset: Offset(_animation.value * 265, 0),
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            if (MediaQuery.of(context).size.shortestSide >
                                600) {
                              return;
                            }
                            // Check for horizontal swipe with a lower threshold
                            if (details.primaryDelta != null &&
                                details.primaryDelta! > 0) {
                              // Forward animation on right swipe
                              _animationController.forward();
                            } else if (details.primaryDelta != null &&
                                details.primaryDelta! < 0) {
                              // Reverse animation on left swipe
                              _animationController.reverse();
                            }
                          },
                          child: ClipRRect(
                            borderRadius: _animationController.status ==
                                    AnimationStatus.completed
                                ? const BorderRadius.all(Radius.circular(24))
                                : const BorderRadius.all(Radius.zero),
                            child: Scaffold(
                                floatingActionButtonLocation:
                                    MediaQuery.of(context).size.shortestSide <
                                            600
                                        ? FloatingActionButtonLocation
                                            .centerDocked
                                        : null,
                                floatingActionButton:
                                    MediaQuery.of(context).size.shortestSide <
                                            600
                                        ? FloatingActionButton(
                                            tooltip: "registered_course".tr,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HomeRegisteredCourses()));
                                            },
                                            child: const Icon(
                                              Icons.subscriptions_rounded,
                                              size: 35,
                                            ),
                                          )
                                        : null,
                                bottomNavigationBar: MediaQuery.of(context)
                                            .size
                                            .shortestSide <
                                        600
                                    ? Transform.translate(
                                        offset:
                                            Offset(0, _animation.value * 100),
                                        child: CustomBottomNavigationBar(
                                          selectedIndex: _currentIndex,
                                          onChange: (int indexSelected) {
                                            setState(() {
                                              _currentIndex = indexSelected;
                                            });
                                          },
                                        ))
                                    : null,
                                extendBodyBehindAppBar: true,
                                extendBody: true,
                                body: IndexedStack(
                                  index: _currentIndex,
                                  children: [
                                    MainHomeScreen(
                                      userState: userState,
                                      currentIndex: _currentIndex,
                                      onProfileTap: () {
                                        setState(() {
                                          _currentIndex = 3;
                                        });
                                      },
                                    ),
                                    const NotificationsScreen(),
                                    const FavoritesScreen(),
                                    const ProfileScreen()
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({
    required this.userState,
    required this.onProfileTap,
    required this.currentIndex,
    super.key,
  });
  final UserLoaded userState;
  final int currentIndex;
  final Function onProfileTap;

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final GlobalKey _groups = GlobalKey();
  final GlobalKey _subscriptions = GlobalKey();
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.currentIndex == 0) {
        ShowCaseWidget.of(context).startShowCase([_groups, _subscriptions]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<RegisteredCoursesBloc>().add(const GetRegisteredCourses());
      },
      child: MediaQuery.of(context).size.shortestSide > 600
          ? Row(
              children: [
                Material(
                  elevation: 10,
                  child: NavigationRail(destinations: [
                    NavigationRailDestination(
                      icon: IconButton(
                        icon: const Icon(Icons.home_rounded),
                        onPressed: () {
                          setState(() {
                            _currentIndex = 0;
                          });
                        },
                      ),
                      label: Text("home".tr),
                    ),
                    NavigationRailDestination(
                      icon: IconButton(
                        icon: const Icon(Icons.notifications),
                        onPressed: () {
                          setState(() {
                            _currentIndex = 1;
                          });
                        },
                      ),
                      label: Text("notifications".tr),
                    ),
                    NavigationRailDestination(
                      icon: IconButton(
                        icon: const Icon(Icons.star_rounded),
                        onPressed: () {
                          setState(() {
                            _currentIndex = 2;
                          });
                        },
                      ),
                      label: Text("favorites".tr),
                    ),
                    NavigationRailDestination(
                      icon: IconButton(
                        icon: const Icon(Icons.person_rounded),
                        onPressed: () {
                          setState(() {
                            _currentIndex = 3;
                          });
                        },
                      ),
                      label: Text("profile".tr),
                    ),
                  ], selectedIndex: _currentIndex),
                ),
                Expanded(
                  child: TwoPane(
                      startPane: SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        widget.onProfileTap();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Image.network(
                                          widget.userState.user.avatar ?? "",
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            'assets/images/unkown_profile_icon.png',
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          widget.onProfileTap();
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${widget.userState.user.firstName} ${widget.userState.user.lastName}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              widget.userState.user.university
                                                  .name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Showcase(
                                      key: _groups,
                                      description: "chat_showcase".tr,
                                      child: InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const GroupsSectionsFilesScreen())),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              border: Border.all(),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(0.6),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                              child: SizedBox(
                                            height: 30,
                                            width: 30,
                                            child:
                                                RiveImport.RiveAnimation.asset(
                                              "assets/RiveAssets/icons.riv",
                                              artboard: "CHAT",
                                              onInit: (artboard) {
                                                RiveImport
                                                    .StateMachineController?
                                                    controller = RiveImport
                                                            .StateMachineController
                                                        .fromArtboard(artboard,
                                                            "CHAT_Interactivity");
                                                artboard
                                                    .addController(controller!);
                                              },
                                            ),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const HomeCarousal(),
                              const SizedBox(
                                height: 8,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  width: double.infinity,
                                  child:
                                      BlocBuilder<SectionsCubit, SectionsState>(
                                    builder: (context, state) {
                                      if (state is SectionsLoading) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "sections".tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                  itemCount: 10,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          SizedBox(
                                                            height: 60,
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Shimmer
                                                                    .fromColors(
                                                                        direction:
                                                                            ShimmerDirection
                                                                                .ttb,
                                                                        baseColor: Theme.of(context).brightness == Brightness.dark
                                                                            ? const Color(
                                                                                0xFF303030)
                                                                            : const Color(
                                                                                0xFFEFEFEF),
                                                                        highlightColor: Theme.of(context).brightness == Brightness.dark
                                                                            ? const Color(
                                                                                0xFF505050)
                                                                            : const Color.fromARGB(
                                                                                255,
                                                                                224,
                                                                                223,
                                                                                223),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              50,
                                                                          height:
                                                                              50,
                                                                          margin: const EdgeInsets
                                                                              .all(
                                                                              5),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        )),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Expanded(
                                                                  child: Shimmer
                                                                      .fromColors(
                                                                          direction: ShimmerDirection
                                                                              .ttb,
                                                                          baseColor: Theme.of(context).brightness == Brightness.dark
                                                                              ? const Color(
                                                                                  0xFF303030)
                                                                              : const Color(
                                                                                  0xFFEFEFEF),
                                                                          highlightColor: Theme.of(context).brightness == Brightness.dark
                                                                              ? const Color(0xFF505050)
                                                                              : const Color.fromARGB(255, 224, 223, 223),
                                                                          child: Container(
                                                                            height:
                                                                                20,
                                                                            margin:
                                                                                const EdgeInsets.all(5),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(50),
                                                                              color: Colors.white,
                                                                            ),
                                                                          )),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                            ),
                                          ],
                                        );
                                      } else if (state is SectionLoading) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "sections".tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 50),
                                                  itemCount:
                                                      state.sections.length,
                                                  itemBuilder: (context,
                                                          index) =>
                                                      SectionWidget(
                                                        section: state
                                                            .sections[index],
                                                        isLoading:
                                                            state.sections[
                                                                    index] ==
                                                                state.section,
                                                      )),
                                            ),
                                          ],
                                        );
                                      } else if (state is SectionsLoaded) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "sections".tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 50),
                                                  itemCount:
                                                      state.sections.length,
                                                  itemBuilder: (context,
                                                          index) =>
                                                      SectionWidget(
                                                          section:
                                                              state.sections[
                                                                  index])),
                                            ),
                                            BlocBuilder<FooterCubit,
                                                FooterState>(
                                              builder: (context, state) {
                                                if (state is FooterLoaded) {
                                                  return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: state.footerData
                                                          .map((e) =>
                                                              SocialMediaIcon(
                                                                  footerData:
                                                                      e))
                                                          .toList());
                                                } else {
                                                  return const SizedBox();
                                                }
                                              },
                                            )
                                          ],
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      endPane: Material(
                        elevation: 10,
                        child: _currentIndex == 0
                            ? const HomeRegisteredCourses()
                            : _currentIndex == 1
                                ? const NotificationsScreen()
                                : _currentIndex == 2
                                    ? const FavoritesScreen()
                                    : _currentIndex == 3
                                        ? const ProfileScreen()
                                        : const SizedBox(),
                      ),
                      paneProportion: Provider.of<LocalizationProvider>(context,
                                      listen: true)
                                  .getLocalization ==
                              const Locale("ar")
                          ? 0.4
                          : 0.6),
                )
              ],
            )
          : SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              widget.onProfileTap();
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.network(
                                widget.userState.user.avatar ?? "",
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/images/unkown_profile_icon.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                widget.onProfileTap();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${widget.userState.user.firstName} ${widget.userState.user.lastName}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    widget.userState.user.university.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Showcase(
                            key: _groups,
                            description: "chat_showcase".tr,
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const GroupsSectionsFilesScreen())),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: RiveImport.RiveAnimation.asset(
                                    "assets/RiveAssets/icons.riv",
                                    artboard: "CHAT",
                                    onInit: (artboard) {
                                      RiveImport.StateMachineController?
                                          controller =
                                          RiveImport.StateMachineController
                                              .fromArtboard(artboard,
                                                  "CHAT_Interactivity");
                                      artboard.addController(controller!);
                                    },
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Showcase(
                            key: _subscriptions,
                            description: "registered_course".tr,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeRegisteredCourses()));
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Icon(
                                    Icons.subscriptions_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const HomeCarousal(),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xFF181818)
                                    : Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.6),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        width: double.infinity,
                        child: BlocBuilder<SectionsCubit, SectionsState>(
                          builder: (context, state) {
                            if (state is SectionsLoading) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "sections".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: 10,
                                        itemBuilder: (context, index) =>
                                            SizedBox(
                                              height: 60,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Shimmer.fromColors(
                                                      direction:
                                                          ShimmerDirection.ttb,
                                                      baseColor: Theme.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? const Color(
                                                              0xFF303030)
                                                          : const Color(
                                                              0xFFEFEFEF),
                                                      highlightColor: Theme.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? const Color(
                                                              0xFF505050)
                                                          : const Color
                                                              .fromARGB(255,
                                                              224, 223, 223),
                                                      child: Container(
                                                        width: 50,
                                                        height: 50,
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors.white,
                                                        ),
                                                      )),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Shimmer.fromColors(
                                                      direction:
                                                          ShimmerDirection.ttb,
                                                      baseColor: Theme.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? const Color(
                                                              0xFF303030)
                                                          : const Color(
                                                              0xFFEFEFEF),
                                                      highlightColor: Theme.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? const Color(
                                                              0xFF505050)
                                                          : const Color
                                                              .fromARGB(255,
                                                              224, 223, 223),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                        height: 15,
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: Colors.white,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            )),
                                  ),
                                ],
                              );
                            } else if (state is SectionLoading) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "sections".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        padding:
                                            const EdgeInsets.only(bottom: 50),
                                        itemCount: state.sections.length,
                                        itemBuilder: (context, index) =>
                                            SectionWidget(
                                              section: state.sections[index],
                                              isLoading:
                                                  state.sections[index] ==
                                                      state.section,
                                            )),
                                  ),
                                ],
                              );
                            } else if (state is SectionsLoaded) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 100),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "sections".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          padding:
                                              const EdgeInsets.only(bottom: 50),
                                          itemCount: state.sections.length,
                                          itemBuilder: (context, index) =>
                                              SectionWidget(
                                                  section:
                                                      state.sections[index])),
                                    ),
                                    BlocBuilder<FooterCubit, FooterState>(
                                      builder: (context, state) {
                                        if (state is FooterLoaded) {
                                          return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: state.footerData
                                                  .map((e) => SocialMediaIcon(
                                                      footerData: e))
                                                  .toList());
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    )
                                  ],
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
