import 'dart:math';

import 'package:flutter/material.dart';

final Random _random = Random();
const Color backgroundColor = Color(0xfff4f6f5);
const Color primaryColor = Color(0xff1a186b);
const Color secondaryColor1 = Color(0xffE6A82E);
const Color secondaryColor2 = Color(0xffB0BEC5);
const Color secondaryColor3 = Color(0xff4CAF50);
const Color secondaryColor4 = Color(0xffFFB199);
const Color grey = Color(0xff9e9e9e);
const Color black = Color(0xff000000);
const Color white = Color(0xfff4f3f7);
const Color aqua = Color(0xff7ce5d7);
const Color pink = Color(0xffe281c1);
const Color red = Color(0xFFFC0000);
const Color green = Color.fromARGB(255, 0, 252, 105);

const Color lightBlue = Color(0xffbabad2);
const Color shimmerBaseColor = Color(0xFFE0E0E0);
const Color shimmerHighlightColor = Color(0xFFF5F5F5);
const Color shimmerBaseColorDark = Color(0xFF424242);
const Color shimmerHighlightColorDark = Color(0xFF616161);

const Color firstRandomColor = Color.fromARGB(255, 223, 226, 252);
const Color secondRandomColor = Color.fromARGB(255, 243, 235, 248);
const Color thirdRandomColor = Color.fromARGB(255, 239, 254, 251);
const Color fourthRandomColor = Color.fromARGB(255, 254, 248, 230);
Color getRandomColor() {
  final List<Color> colors = [
    firstRandomColor,
    secondRandomColor,
    thirdRandomColor,
    fourthRandomColor,
  ];

  int randomIndex = _random
      .nextInt(colors.length); // Generates a random index between 0 and 3
  return colors[randomIndex];
}
