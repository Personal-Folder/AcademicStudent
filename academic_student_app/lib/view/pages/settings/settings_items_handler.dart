import 'package:academic_student/view/pages/settings/settings_item.dart';
import 'package:flutter/material.dart';

class SettingsItemsHandler {
  static List<SettingsItem> settingsItems() => [
        SettingsItem(
          icon: Icons.translate_rounded,
          title: "change_language",
          callback: () {},
        ),
        SettingsItem(
          icon: Icons.priority_high_rounded,
          title: "about_us",
          callback: () {},
        ),
        SettingsItem(
          icon: Icons.document_scanner_rounded,
          title: "terms_conditions",
          callback: () {},
        ),
        SettingsItem(
          icon: Icons.security_outlined,
          title: "privacy_policy",
          callback: () {},
        ),
        SettingsItem(
          icon: Icons.call_rounded,
          title: "technical_support",
          callback: () {},
        ),
        SettingsItem(
          icon: Icons.logout_rounded,
          title: "logout",
          color: Colors.red,
          callback: () {},
        ),
      ];
}
