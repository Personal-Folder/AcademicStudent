import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:academic_student/utils/constants/display_size.dart';

class WebViewAttachment extends StatefulWidget {
  final String title;
  final String url;

  const WebViewAttachment({super.key, required this.url, required this.title});

  @override
  State<WebViewAttachment> createState() => _WebViewAttachmentState();
}

class _WebViewAttachmentState extends State<WebViewAttachment> {
  // Controllers and state variables
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  late PullToRefreshController pullToRefreshController;

  String currentUrl = "";
  double progress = 0.0;
  bool isLoading = false;

  // WebView Options
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
    ),
  );

  @override
  void initState() {
    log("url :  ${widget.url}");
    super.initState();
    _initializePullToRefresh();
  }

  void _initializePullToRefresh() {
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: Colors.blue),
      onRefresh: () async {
        if (Platform.isAndroid) {
          await webViewController?.reload();
        } else if (Platform.isIOS) {
          final url = await webViewController?.getUrl();
          if (url != null) {
            await webViewController?.loadUrl(urlRequest: URLRequest(url: url));
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _buildWebView(),
            if (progress < 1.0) LinearProgressIndicator(value: progress),
            if (isLoading) _buildLoadingOverlay(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWebView() {
    return InAppWebView(
      key: webViewKey,
      initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
      initialOptions: options,
      pullToRefreshController: pullToRefreshController,

      // WebView Callbacks
      onWebViewCreated: (controller) => webViewController = controller,
      onLoadStart: (controller, url) =>
          setState(() => currentUrl = url.toString()),
      onLoadStop: (controller, url) async {
        pullToRefreshController.endRefreshing();
        setState(() => currentUrl = url.toString());
      },
      onLoadError: (controller, url, code, message) {
        pullToRefreshController.endRefreshing();
      },
      onProgressChanged: (controller, progressValue) {
        setState(() => progress = progressValue / 100);
        if (progressValue == 100) {
          pullToRefreshController.endRefreshing();
        }
      },

      // Permission handling
      androidOnPermissionRequest: (controller, origin, resources) async =>
          PermissionRequestResponse(
        resources: resources,
        action: PermissionRequestResponseAction.GRANT,
      ),

      // Handle navigation actions
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        final uri = navigationAction.request.url;
        if (uri != null && !_isSupportedUrlScheme(uri.scheme)) {
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
            return NavigationActionPolicy.CANCEL;
          }
        }
        return NavigationActionPolicy.ALLOW;
      },
    );
  }

  Widget _buildLoadingOverlay(BuildContext context) {
    return Container(
      height: displayHeight(context),
      width: displayWidth(context),
      color: Colors.grey.withOpacity(0.3),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  bool _isSupportedUrlScheme(String? scheme) {
    const supportedSchemes = [
      "http",
      "https",
      "file",
      "chrome",
      "data",
      "javascript",
      "about"
    ];
    return scheme != null && supportedSchemes.contains(scheme);
  }

  @override
  void dispose() {
    // pullToRefreshController.dispose();
    super.dispose();
  }
}
