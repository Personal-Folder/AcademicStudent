import 'package:flutter/material.dart';

extension ColumnExtension on Column {
  Column applyPadding({
    required EdgeInsets padding,
  }) {
    List<Widget> paddingChildren = [];
    for (var child in children) {
      paddingChildren.add(
        Padding(
          padding: padding,
          child: child,
        ),
      );
    }
    return Column(
      children: paddingChildren,
    );
  }
}
