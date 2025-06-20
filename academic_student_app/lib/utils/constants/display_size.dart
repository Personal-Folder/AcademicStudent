import 'package:flutter/material.dart';

double displayHeight(context) => MediaQuery.of(context).size.height;
double displayWidth(context) => MediaQuery.of(context).size.width;

double websiteSize = 800;

class ResponsiveSizes {
  final mobileSize = const Size(750, 800);
  final websiteSize = const Size(1920, 900);

  bool isMobile(context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.width;

    if (mediaWidth < mobileSize.width  ||  mediaHeight < mobileSize.height) {
      return true;
    } else {
      return false;
    }
  }
}

const double appBarHeight = 50;
