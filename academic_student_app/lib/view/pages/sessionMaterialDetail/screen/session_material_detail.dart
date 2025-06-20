import 'dart:developer';
import 'dart:io';

import 'package:academic_student/core/models/pdf_attachments.dart';
import 'package:academic_student/core/models/session_material.dart';
import 'package:academic_student/core/models/subscription_type.dart';
import 'package:academic_student/core/models/user.dart';
import 'package:academic_student/core/models/video_attachment.dart';
import 'package:academic_student/core/providers/i18n/localization_provider.dart';
import 'package:academic_student/core/services/payment_method_service.dart';
import 'package:academic_student/core/services/session_material_service.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:academic_student/view/shared/widgets/pdf_view_attachments.dart';
import 'package:academic_student/view/shared/widgets/web_view_attachments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SessionMaterialDetail extends StatefulWidget {
  final int sessionMaterialId;

  const SessionMaterialDetail({super.key, required this.sessionMaterialId});

  @override
  State<SessionMaterialDetail> createState() => _SessionMaterialDetailState();
}

class _SessionMaterialDetailState extends State<SessionMaterialDetail> {
  SessionMaterial? sessionMaterial;
  bool isSubscribe = false;
  bool isLoading = true;
  bool paymentLoading = false;
  bool visibleDescription = false;
  String? copyRights;
  List<SubscriptionType> subscriptionTypes = [];
  List<VideoEnrollment> videoEnrollments = [];
  List<AttachmentEnrollment> attachmentEnrollments = [];
  final _key = GlobalKey<ExpandableFabState>();

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    log("widget.sessionMaterialId : ${widget.sessionMaterialId}");
    await SessionMaterialsService()
        .showSessionMaterial(widget.sessionMaterialId)
        .then((result) {
      result.fold(
        (listResult) {
          if (listResult[0] == 'success') {
            setState(() {
              sessionMaterial =
                  SessionMaterial.fromMap(listResult[1]['details']);
              isSubscribe = listResult[1]['is_subscribe'];
              subscriptionTypes = subscriptionTypesFromMapList(
                  listResult[1]['subscription_types']);
              videoEnrollments = videovideoEnrollmentFromMapList(
                  listResult[1]['enrollment']['videos']);
              attachmentEnrollments = attachmentEnrollmentFromMapList(
                  listResult[1]['enrollment']['attachments']);
              copyRights = listResult[1]['copy_rights'];
            });
          }
        },
        (stringResult) {},
      );
    });
    setState(() {
      isLoading = false;
    });
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
        title: sessionMaterial != null
            ? Text(sessionMaterial?.name ?? "")
            : const Text(""),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        duration: const Duration(milliseconds: 500),
        distance: 150.0,
        type: ExpandableFabType.fan,
        pos: Provider.of<LocalizationProvider>(context, listen: true)
                    .getLocalization ==
                const Locale("ar")
            ? ExpandableFabPos.left
            : ExpandableFabPos.right,
        childrenOffset: const Offset(0, 20),
        childrenAnimation: ExpandableFabAnimation.rotate,
        fanAngle: 90,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.more_vert_rounded),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: const CircleBorder(),
          angle: 3.14 * 2,
        ),
        closeButtonBuilder: FloatingActionButtonBuilder(
          size: 56,
          builder: (BuildContext context, void Function()? onPressed,
              Animation<double> progress) {
            return IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.close_rounded,
                size: 40,
              ),
            );
          },
        ),
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.black.withOpacity(0.5),
          blur: 5,
        ),
        onOpen: () {
          debugPrint('onOpen');
        },
        afterOpen: () {
          debugPrint('afterOpen');
        },
        onClose: () {
          debugPrint('onClose');
        },
        afterClose: () {
          debugPrint('afterClose');
        },
        children: [
          FloatingActionButton.small(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) => Platform.isIOS
                      ? CupertinoAlertDialog(
                          title: Text(
                            "course_information".tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          ),
                          content: Text(
                            "${sessionMaterial?.name ?? ""} - ${sessionMaterial?.code ?? ""} - ${(sessionMaterial?.description ?? "").toUpperCase()}",
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
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"))
                          ],
                        )
                      : AlertDialog(
                          title: Text(
                            "course_information".tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          ),
                          content: Text(
                            "${sessionMaterial?.name ?? ""} - ${sessionMaterial?.code ?? ""} - ${(sessionMaterial?.description ?? "").toUpperCase()}",
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
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"))
                          ],
                        ));
            },
            heroTag: null,
            tooltip: "course_information".tr,
            child: const Icon(Icons.info_outline_rounded),
          ),
          if (subscriptionTypes.isNotEmpty)
            FloatingActionButton.small(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      if (Platform.isIOS) {
                        return CupertinoAlertDialog(
                          title: Text("subscriptions".tr),
                          content: SizedBox(
                            height: 300,
                            width: 300,
                            child: ListView(
                              children: subscriptionTypes
                                  .map(
                                    (subscriptionType) => Card(
                                      child: ListTile(
                                        title: Text(subscriptionType.name),
                                        onTap: () async {
                                          setState(() {
                                            paymentLoading = true;
                                          });
                                          await PaymentService()
                                              .getReDirectUrl(
                                            widget.sessionMaterialId,
                                            subscriptionType.id,
                                            'whatsapp',
                                          )
                                              .then((result) {
                                            result.fold(
                                              (listResult) async {
                                                if (listResult[0] ==
                                                    'success') {
                                                  if (!await launchUrl(
                                                    Uri.parse(listResult[1]),
                                                    mode: LaunchMode
                                                        .externalApplication,
                                                  )) {
                                                    CustomDialogs().errorDialog(
                                                        message:
                                                            'Couldn\'t Continue The Payment, Ciintact Us for more information');
                                                  }
                                                }
                                              },
                                              (stringResult) {
                                                CustomDialogs().errorDialog(
                                                    message: stringResult);
                                              },
                                            );
                                          });
                                          setState(() {
                                            paymentLoading = false;
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      } else {
                        return AlertDialog(
                          title: Text("subscriptions".tr),
                          content: SizedBox(
                            height: 300,
                            width: 300,
                            child: ListView(
                              children: subscriptionTypes
                                  .map(
                                    (subscriptionType) => Card(
                                      child: ListTile(
                                        title: Text(subscriptionType.name),
                                        onTap: () async {
                                          setState(() {
                                            paymentLoading = true;
                                          });
                                          await PaymentService()
                                              .getReDirectUrl(
                                            widget.sessionMaterialId,
                                            subscriptionType.id,
                                            'whatsapp',
                                          )
                                              .then((result) {
                                            result.fold(
                                              (listResult) async {
                                                if (listResult[0] ==
                                                    'success') {
                                                  if (!await launchUrl(
                                                    Uri.parse(listResult[1]),
                                                    mode: LaunchMode
                                                        .externalApplication,
                                                  )) {
                                                    CustomDialogs().errorDialog(
                                                        message:
                                                            'Couldn\'t Continue The Payment, Ciintact Us for more information');
                                                  }
                                                }
                                              },
                                              (stringResult) {
                                                CustomDialogs().errorDialog(
                                                    message: stringResult);
                                              },
                                            );
                                          });
                                          setState(() {
                                            paymentLoading = false;
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      }
                    });
              },
              child: const Icon(Icons.subscriptions_rounded),
            ),
          FloatingActionButton.small(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) => Platform.isIOS
                      ? CupertinoAlertDialog(
                          title: Text(
                            "warning_title".tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          ),
                          content: Text(
                            "warning_content".tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.red),
                          ),
                          actions: [
                            CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"))
                          ],
                        )
                      : AlertDialog(
                          title: Text(
                            "warning_title".tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          ),
                          content: Text(
                            "warning_content".tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.red),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"))
                          ],
                        ));
            },
            child: const Icon(Icons.warning_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.primary
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (sessionMaterial?.name ?? "").toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                      ),
                      Text(
                        (sessionMaterial?.code ?? "").toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ),
                Table(
                    border: TableBorder.all(
                      color: Colors.grey,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'days_label'.tr,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'time_label'.tr,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            ),
                          ),
                        ],
                      ),
                      ...(sessionMaterial?.schedule ?? [])
                          .map(
                            (schedule) => TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    schedule['day'],
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    "${DateFormat("h:mm a").format(DateFormat("H:mm:ss").parse(schedule['time_from']))} - ${DateFormat("h:mm a").format(DateFormat("H:mm:ss").parse(schedule['time_to']))}",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ]),
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
                videoEnrollments.isNotEmpty
                    ? SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: videoEnrollments.length,
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () async {
                                    openEnrollment(
                                      title: videoEnrollments[index].title,
                                      url:
                                          '${videoEnrollments[index].viewerLink}?token=${User.token}',
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    height: 70,
                                    width: 250,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10),
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
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.white),
                                                  child: const Icon(
                                                    Icons.play_arrow_rounded,
                                                    color: Colors.black,
                                                  )),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Text(
                                                videoEnrollments[index].title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .surface
                                                            : Theme.of(context)
                                                                .colorScheme
                                                                .onSurface,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                      )
                    : Text(
                        "No Lesson Lectures",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface),
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
                attachmentEnrollments.isNotEmpty
                    ? Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              itemCount: attachmentEnrollments.length,
                              itemBuilder: (context, index) => AnimatedSlide(
                                    offset: Offset.zero,
                                    duration: Duration(
                                        milliseconds: 300 + (index * 100)),
                                    child: GestureDetector(
                                      onTap: () async {
                                        openEnrollment(
                                          title: attachmentEnrollments[index]
                                              .title,
                                          url:
                                              '${attachmentEnrollments[index].link}?token=${User.token}',
                                        );
                                      },
                                      child: Card(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: ListTile(
                                          leading: Image.asset(
                                            "assets/images/academic-student/pdf.png",
                                            width: 34,
                                            height: 34,
                                            fit: BoxFit.cover,
                                          ),
                                          title: Text(
                                            attachmentEnrollments[index].title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                      )
                    : Text(
                        "No Course Attachments",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
