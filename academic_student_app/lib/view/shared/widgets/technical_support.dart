import 'package:academic_student/core/providers/contact_us_cubit/cubit/contact_us_cubit.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TechnicalSupport extends StatelessWidget {
  const TechnicalSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsCubit, ContactUsState>(
      builder: (context, state) {
        if (state is ContactUsLoaded) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'for_technical_support_label'.tr,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: state.contactUsInfos
                    .map(
                      (info) => IconButton(
                        onPressed: () async {
                          String url = '';
                          if (info.value.isEmail) {
                            url = 'mailto:${info.value}';
                          } else if (info.value.isPhoneNumber) {
                            url = 'tel:${info.value}';
                          } else {
                            url = info.value;
                          }
                          if (!await launchUrl(
                            Uri.parse(url),
                            mode: LaunchMode.externalApplication,
                          )) {
                            CustomDialogs()
                                .errorDialog(message: 'Couldn\'t Launch Url');
                          }
                        },
                        icon: SvgPicture.asset(
                          'assets/icons/${info.type}.svg',
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.primary,
                            BlendMode.srcATop,
                          ),
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
