import 'package:academic_student/core/providers/contact_us_cubit/cubit/contact_us_cubit.dart';
import 'package:academic_student/core/services/technical_support_service.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:academic_student/view/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TechnicalSupportScreen extends StatefulWidget {
  const TechnicalSupportScreen({super.key});

  @override
  State<TechnicalSupportScreen> createState() => _TechnicalSupportScreenState();
}

class _TechnicalSupportScreenState extends State<TechnicalSupportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Center(
          child: SizedBox(
            width: websiteSize,
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextField(
                          controller: _subjectController,
                          hintText: "subject_field".tr),
                      AppTextField(
                        controller: _bodyController,
                        hintText: 'body_field'.tr,
                        maxLines: 5,
                        maxLength: 400,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              await TechnicalSupportService()
                                  .sendTechnicalSupportMessage(
                                subject: _subjectController.text,
                                body: _bodyController.text,
                              )
                                  .then((value) {
                                if (value[0] == 'success') {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('msg_sent_successfully'.tr),
                                      actions: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    technicalSupportScreenRoute);
                                          },
                                          icon: const Icon(Icons.check),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                setState(() {
                                  isLoading = false;
                                });
                              });
                            },
                            child: isLoading
                                ? const CircularProgressIndicator.adaptive()
                                : Text("submit_msg".tr)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<ContactUsCubit, ContactUsState>(
                        builder: (context, state) {
                          if (state is ContactUsLoaded) {
                            return Row(
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
                                          CustomDialogs().errorDialog(
                                              message: 'Couldn\'t Launch Url');
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
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
