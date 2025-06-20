import 'package:academic_student/core/models/payment_method.dart';
import 'package:academic_student/utils/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentMethodWidget extends StatefulWidget {
  final PaymentMethod paymentMethod;
  final String selectedMethod;
  final Function(String id) onChanged;
  const PaymentMethodWidget({
    required this.paymentMethod,
    required this.onChanged,
    required this.selectedMethod,
    super.key,
  });

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
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

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    const double widgetWidth = 280;
    const double widgetHeight = 200;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      width: double.infinity,
      height: widgetHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(180),
                ),
                value: widget.selectedMethod == widget.paymentMethod.key,
                onChanged: (_) => widget.onChanged(widget.paymentMethod.key),
              ),
              Text(
                widget.paymentMethod.name,
              ),
            ],
          ),
          Expanded(
            child: isLoading
                ? Shimmer.fromColors(
                    baseColor: white,
                    highlightColor: Colors.grey[300]!,
                    child: const SizedBox(
                      width: widgetWidth,
                      height: widgetHeight,
                    ),
                  )
                : Container(
                    width: widgetWidth,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    clipBehavior: Clip.hardEdge,
                    alignment: Alignment.center,
                    child: kIsWeb
                        ? ImageNetwork(
                            image: widget.paymentMethod.image,
                            height: widgetHeight,
                            width: widgetWidth,
                          )
                        : InAppWebView(
                            key: webViewKey,
                            initialUrlRequest: URLRequest(
                                url: Uri.parse(widget.paymentMethod.image)),
                            initialOptions: options,
                            onWebViewCreated: (controller) {
                              webViewController = controller;
                            },
                            shouldOverrideUrlLoading:
                                (controller, navigationAction) async {
                              var uri = navigationAction.request.url!;

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
                                  return NavigationActionPolicy.CANCEL;
                                }
                              }

                              return NavigationActionPolicy.ALLOW;
                            },
                            onConsoleMessage: (controller, consoleMessage) {
                            },
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
