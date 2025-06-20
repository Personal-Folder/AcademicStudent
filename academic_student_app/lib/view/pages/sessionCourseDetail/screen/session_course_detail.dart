import 'dart:developer';

import 'package:academic_student/core/models/registered_course.dart';
import 'package:academic_student/core/models/user.dart';
import 'package:academic_student/core/providers/registered_course_bloc/registered_course_details_bloc.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:academic_student/view/shared/widgets/leading_back_button.dart';
import 'package:academic_student/view/shared/widgets/pdf_view_attachments.dart';
import 'package:academic_student/view/shared/widgets/web_view_attachments.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class SessionCourseDetail extends StatefulWidget {
  final RegisteredCourse course;

  const SessionCourseDetail({super.key, required this.course});

  @override
  State<SessionCourseDetail> createState() => _SessionCourseDetailState();
}

class _SessionCourseDetailState extends State<SessionCourseDetail> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    context
        .read<RegisteredCourseDetailsBloc>()
        .add(GetRegisteredCourseDetails(courseId: widget.course.id ?? -1));
  }

  goToPaymentMethod(int sessionId, int subscriptionTypeId) {
    Navigator.of(context).pushNamed(
      paymentMethodScreenRoute,
      arguments: [
        sessionId,
        subscriptionTypeId,
      ],
    );
  }

  openEnrollment({
    required String url,
    required String title,
  }) {
    log("url : $url");
    if (url.contains('pdf')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfViewAttachment(
            title: title,
            url: url,
          ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WebViewAttachment(
            title: title,
            url: url,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingBackButton(
          screenContext: context,
        ),
        title: Text(widget.course.name ?? ""),
      ),
      body: BlocConsumer<RegisteredCourseDetailsBloc,
          RegisteredCourseDetailsState>(
        listener: (context, state) {
          if (state is RegisteredCourseDetailsLoaded) {
            Future.delayed(
                const Duration(milliseconds: 500),
                () => setState(() {
                      _visible = true;
                    }));
          }
        },
        builder: (context, state) {
          if (state is RegisteredCourseDetailsLoading) {
            return const LoadingWidget();
          } else if (state is RegisteredCourseDetailsLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "course_information".tr,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${widget.course.name} - ${widget.course.code} - ${(widget.course.type ?? "").toUpperCase()}",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "lesson_lectures".tr,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      state.details.videos.isEmpty
                          ? Text(
                              "No Videos",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            )
                          : SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.details.videos.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: () async {
                                          if (kIsWeb) {
                                            if (!await launchUrl(
                                              Uri.parse(
                                                  '${state.details.videos[index].viewerLink}?token=${User.token}'),
                                              mode: kIsWeb
                                                  ? LaunchMode
                                                      .externalApplication
                                                  : LaunchMode.inAppWebView,
                                            )) {
                                              CustomDialogs().errorDialog(
                                                  message: 'error');
                                            }
                                          } else {
                                            openEnrollment(
                                              title: state
                                                  .details.videos[index].title,
                                              url:
                                                  '${state.details.videos[index].viewerLink}?token=${User.token}',
                                            );
                                          }
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          height: 70,
                                          width: 250,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.asset(
                                                  "assets/images/lecture.png",
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .white),
                                                        child: const Icon(
                                                          Icons
                                                              .play_arrow_rounded,
                                                          color: Colors.black,
                                                        )),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Text(state.details
                                                        .videos[index].title)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                            ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "course_attachments".tr,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      state.details.attachments.isEmpty
                          ? Text(
                              "No Attachments",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            )
                          : Expanded(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    itemCount: state.details.attachments.length,
                                    itemBuilder: (context, index) =>
                                        AnimatedSlide(
                                          offset: _visible
                                              ? Offset.zero
                                              : const Offset(-1, 0),
                                          duration: Duration(
                                              milliseconds:
                                                  300 + (index * 100)),
                                          child: GestureDetector(
                                            onTap: () async {
                                              if (kIsWeb) {
                                                if (!await launchUrl(
                                                  Uri.parse(
                                                      '${state.details.attachments[index].viewerLink}?token=${User.token}'),
                                                  mode: kIsWeb
                                                      ? LaunchMode
                                                          .externalApplication
                                                      : LaunchMode.inAppWebView,
                                                )) {
                                                  CustomDialogs().errorDialog(
                                                      message: 'error');
                                                }
                                              } else {
                                                openEnrollment(
                                                  title: state.details
                                                      .attachments[index].title,
                                                  url:
                                                      '${state.details.attachments[index].viewerLink}?token=${User.token}',
                                                );
                                              }
                                            },
                                            child: Card(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              child: ListTile(
                                                leading: Image.asset(
                                                  "assets/images/academic-student/pdf.png",
                                                  width: 34,
                                                  height: 34,
                                                  fit: BoxFit.cover,
                                                ),
                                                title: Text(
                                                  state.details
                                                      .attachments[index].title,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Shimmer.fromColors(
              direction: ShimmerDirection.ttb,
              baseColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF303030)
                  : const Color(0xFFEFEFEF),
              highlightColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF505050)
                  : const Color.fromARGB(255, 224, 223, 223),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 12,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
              direction: ShimmerDirection.ttb,
              baseColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF303030)
                  : const Color(0xFFEFEFEF),
              highlightColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF505050)
                  : const Color.fromARGB(255, 224, 223, 223),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 12,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
              direction: ShimmerDirection.ttb,
              baseColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF303030)
                  : const Color(0xFFEFEFEF),
              highlightColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF505050)
                  : const Color.fromARGB(255, 224, 223, 223),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
              )),
          const SizedBox(
            height: 5,
          ),
          Shimmer.fromColors(
              direction: ShimmerDirection.ttb,
              baseColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF303030)
                  : const Color(0xFFEFEFEF),
              highlightColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF505050)
                  : const Color.fromARGB(255, 224, 223, 223),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 12,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
              )),
          const SizedBox(
            height: 5,
          ),
          Shimmer.fromColors(
              direction: ShimmerDirection.ttb,
              baseColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF303030)
                  : const Color(0xFFEFEFEF),
              highlightColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF505050)
                  : const Color.fromARGB(255, 224, 223, 223),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 12,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
