import 'dart:io';

import 'package:academic_student/core/providers/i18n/localization_provider.dart';
import 'package:academic_student/core/providers/user_bloc/bloc/user_bloc.dart';
import 'package:academic_student/view/pages/aboutUs/screen/about_us.dart';
import 'package:academic_student/view/pages/edit_profile/edit_profile_screen.dart';
import 'package:academic_student/view/pages/instructors/instructors_screen.dart';
import 'package:academic_student/view/pages/privacyPolicy/screen/privacy_policy.dart';
import 'package:academic_student/view/pages/technicalSupport/screen/technical_support.dart';
import 'package:academic_student/view/pages/termsConditions/screen/terms_condition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? pickedImageBytes;
  String? fileName;

  bool isRLTFlag = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.tertiary
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                ),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 150,
                          width: 150,
                          margin: const EdgeInsets.only(top: 30),
                          clipBehavior: Clip.hardEdge,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: Image.network(
                            state is UserLoaded ? state.user.avatar ?? "" : "",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              'assets/images/unkown_profile_icon.png',
                              width: 150,
                              height: 150,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ));
                  },
                )
              ],
            ),
          ),
          BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            return SizedBox(
              height: 90,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  state is UserLoaded
                      ? Text(
                          "${state.user.firstName} ${state.user.lastName}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                        )
                      : const SizedBox(),
                  state is UserLoaded
                      ? Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black.withOpacity(0.2)),
                          child: Text(
                            state.user.email,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            );
          }),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8).copyWith(bottom: 70),
              children: [
                Card(
                  elevation: 0,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfileScreen()));
                    },
                    leading: const Icon(Icons.edit_rounded),
                    title: Text("edit_profile".tr),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          clipBehavior: Clip.hardEdge,
                          builder: (context) => const InstructorsScreen());
                    },
                    leading: const Icon(Icons.group_rounded),
                    title: Text("instructors".tr),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          clipBehavior: Clip.hardEdge,
                          builder: (context) => const TechnicalSupportScreen());
                    },
                    leading: const Icon(Icons.headset_mic_rounded),
                    title: Text("technical_support".tr),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Card(
                                    child: ListTile(
                                      onTap: () =>
                                          Provider.of<LocalizationProvider>(
                                                  context,
                                                  listen: false)
                                              .setLocalization(
                                        const Locale('en'),
                                      ),
                                      title: const Text("English"),
                                      titleTextStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color:
                                                  Provider.of<LocalizationProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .getLocalization ==
                                                          const Locale("en")
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                              fontWeight:
                                                  Provider.of<LocalizationProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .getLocalization ==
                                                          const Locale("en")
                                                      ? FontWeight.bold
                                                      : null),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Card(
                                    child: ListTile(
                                      onTap: () =>
                                          Provider.of<LocalizationProvider>(
                                                  context,
                                                  listen: false)
                                              .setLocalization(
                                        const Locale('ar'),
                                      ),
                                      title: const Text("عربي"),
                                      titleTextStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color:
                                                  Provider.of<LocalizationProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .getLocalization ==
                                                          const Locale("ar")
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                              fontWeight:
                                                  Provider.of<LocalizationProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .getLocalization ==
                                                          const Locale("ar")
                                                      ? FontWeight.bold
                                                      : null),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    leading: const Icon(Icons.translate_rounded),
                    title: Text("change_language".tr),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    onTap: () async {
                      await showModalBottomSheet(
                          context: context,
                          clipBehavior: Clip.hardEdge,
                          isScrollControlled: true,
                          builder: (context) => SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: const AboutUsScreen()));
                    },
                    leading: const Icon(Icons.info_outline_rounded),
                    title: Text("about_us".tr),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    onTap: () async {
                      await showModalBottomSheet(
                          context: context,
                          clipBehavior: Clip.hardEdge,
                          isScrollControlled: true,
                          builder: (context) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.9,
                                child: const TermsConditionScreen(),
                              ));
                    },
                    leading: const Icon(Icons.description_rounded),
                    title: Text("terms_conditions".tr),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    onTap: () async {
                      await showModalBottomSheet(
                          context: context,
                          clipBehavior: Clip.hardEdge,
                          isScrollControlled: true,
                          builder: (context) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.9,
                                child: const PrivacyPolicyScreen(),
                              ));
                    },
                    leading: const Icon(Icons.policy_rounded),
                    title: Text("privacy_policy".tr),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            if (Platform.isAndroid) {
                              return AlertDialog(
                                title: Text(
                                  "logout_title".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                ),
                                content: Text(
                                  "logout_content".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("cancel".tr)),
                                  TextButton(
                                      onPressed: () => context
                                          .read<UserBloc>()
                                          .add(UserLogout()),
                                      child: Text("logout".tr)),
                                ],
                              );
                            }
                            return CupertinoAlertDialog(
                              title: Text(
                                "logout_title".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                              ),
                              content: Text(
                                "logout_content".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("cancel".tr)),
                                CupertinoDialogAction(
                                    onPressed: () => context
                                        .read<UserBloc>()
                                        .add(UserLogout()),
                                    child: Text("logout".tr)),
                              ],
                            );
                          });
                    },
                    leading: const Icon(Icons.logout),
                    title: Text("logout".tr),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            if (Platform.isAndroid) {
                              return AlertDialog(
                                title: Text(
                                  "delete_account_title".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                ),
                                content: Text(
                                  "delete_account_content".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("cancel".tr)),
                                  TextButton(
                                      onPressed: () => context
                                          .read<UserBloc>()
                                          .add(DeleteUser()),
                                      child: Text(
                                        "delete".tr,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      )),
                                ],
                              );
                            }
                            return CupertinoAlertDialog(
                              title: Text(
                                "delete_account_title".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                              ),
                              content: Text(
                                "delete_account_content".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("cancel".tr)),
                                CupertinoDialogAction(
                                    onPressed: () => context
                                        .read<UserBloc>()
                                        .add(DeleteUser()),
                                    child: Text(
                                      "delete".tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    )),
                              ],
                            );
                          });
                    },
                    leading: const Icon(Icons.delete_rounded),
                    title: Text(
                      "delete_account".tr,
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
