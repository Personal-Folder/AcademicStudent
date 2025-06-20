import 'dart:io';

import 'package:flutter/services.dart';

class DisableScreenshots {
  static Future<void> disable() async {
    if (Platform.isIOS) {
      await _disableScreenshotsIOS();
    }
  }

  static Future<void> _disableScreenshotsIOS() async {
    const platform = MethodChannel('disable_screenshots');
    try {
      await platform.invokeMethod('disable');
    } on PlatformException {
      rethrow;
    }
  }
}
