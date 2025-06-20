import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/utils/constants/helper.dart';
import 'package:academic_student/utils/constants/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestDetailAttachments extends StatelessWidget {
  final List attachments;
  final String label;
  const RequestDetailAttachments(
      {super.key, required this.attachments, required this.label});

  @override
  Widget build(BuildContext context) {
    final GlobalKey webViewKey = GlobalKey();

    final InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
        ),
        android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
        ),
        ios: IOSInAppWebViewOptions(
          allowsInlineMediaPlayback: true,
        ));

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          width: double.infinity,
          child: Text(
            label.tr,
            textAlign: TextAlign.start,
            style: GoogleFonts.tajawal(
              fontSize: 18,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: grey,
            ),
          ),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: attachments.map((attachment) {
                ValueNotifier<bool> isDownloaded = ValueNotifier(false);
                ValueNotifier<bool> isDownloading = ValueNotifier(false);

                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  alignment: Alignment.center,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/academic-student/pdf_word_icon.png',
                          height: 30,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: IconButton(
                                onPressed: () async {
                                  // ignore: unused_local_variable
                                  InAppWebViewController? webViewController;
                                  ValueNotifier<int> loadingValue =
                                      ValueNotifier(0);
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                        child: ValueListenableBuilder(
                                      valueListenable: loadingValue,
                                      builder: (context, value, child) {
                                        if (value == 100) {
                                          return InAppWebView(
                                            key: webViewKey,
                                            initialUrlRequest: URLRequest(
                                                url: Uri.parse(
                                              (attachment as String)
                                                      .isImageFileName
                                                  ? storageApi + attachment
                                                  : 'https://docs.google.com/viewer?url=$storageApi$attachment',
                                            )),
                                            initialOptions: options,
                                            onWebViewCreated: (controller) {
                                              webViewController = controller;
                                            },
                                            shouldOverrideUrlLoading:
                                                (controller,
                                                    navigationAction) async {
                                              var uri =
                                                  navigationAction.request.url!;

                                              if (![
                                                "http",
                                                "https",
                                                "file",
                                                "chrome",
                                                "data",
                                                "javascript",
                                                "about"
                                              ].contains(uri.scheme)) {
                                                if (await canLaunchUrl(uri)) {
                                                  // Launch the App
                                                  await launchUrl(
                                                    uri,
                                                  );
                                                  // and cancel the request
                                                  return NavigationActionPolicy
                                                      .CANCEL;
                                                }
                                              }

                                              return NavigationActionPolicy
                                                  .ALLOW;
                                            },
                                            onProgressChanged:
                                                (controller, progress) {
                                              loadingValue.value = progress;
                                            },
                                            onConsoleMessage:
                                                (controller, consoleMessage) {
                                            },
                                          );
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: value.toDouble() / 100,
                                          ),
                                        );
                                      },
                                    )),
                                  );
                                },
                                icon: const Icon(
                                  Icons.remove_red_eye,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            ValueListenableBuilder(
                                valueListenable: isDownloading,
                                builder: (context, downloading, child) {
                                  if (downloading) {
                                    return const SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 4,
                                      ),
                                    );
                                  }
                                  return ValueListenableBuilder(
                                      valueListenable: isDownloaded,
                                      builder: (contex, value, widget) {
                                        if (value) {
                                          return const Flexible(
                                            child: Icon(
                                              Icons.check,
                                              color: primaryColor,
                                            ),
                                          );
                                        }
                                        return Flexible(
                                          child: IconButton(
                                            onPressed: () async {
                                              isDownloading.value = true;
                                              await downloadFile(attachment)
                                                  .then((result) {
                                                isDownloaded.value = result[0];
                                                isDownloading.value = false;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.download,
                                              color: primaryColor,
                                            ),
                                          ),
                                        );
                                      });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
