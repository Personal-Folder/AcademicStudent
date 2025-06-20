import 'package:academic_student/core/providers/user_bloc/bloc/user_bloc.dart';
import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/view/pages/settings/settings_item.dart';
import 'package:academic_student/view/pages/settings/settings_items_handler.dart';
import 'package:academic_student/view/shared/widgets/large_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: state.user.avatar != null
                            ? kIsWeb
                                ? ImageNetwork(
                                    image: state.user.avatar!,
                                    height: 50,
                                    width: 50,
                                    borderRadius: BorderRadius.circular(90),
                                    fitWeb: BoxFitWeb.cover,
                                  )
                                : Image.network(
                                    state.user.avatar!,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )
                            : Image.asset(
                                'assets/images/unkown_profile_icon.png',
                                fit: BoxFit.contain,
                                height: 100,
                                width: 100,
                              ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${state.user.firstName} ${state.user.lastName}",
                            style: GoogleFonts.tajawal(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            state.user.email,
                            style: GoogleFonts.tajawal(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "${state.user.countryCode} ${state.user.phone}",
                            style: GoogleFonts.tajawal(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            state.user.university.name,
                            style: GoogleFonts.tajawal(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LargeButton(
                          title: 'edit_profile'.tr,
                          minWidth: MediaQuery.of(context).size.width / 2.4,
                          onPressed: () {},
                          textStyle: TextStyle()),
                      LargeButton(
                          title: 'delete_account'.tr,
                          minWidth: MediaQuery.of(context).size.width / 2.4,
                          onPressed: () {},
                          textStyle: TextStyle()),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ...SettingsItemsHandler.settingsItems()
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
