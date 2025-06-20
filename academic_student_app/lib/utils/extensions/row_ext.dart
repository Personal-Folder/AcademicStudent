import 'package:flutter/material.dart';

extension RowExtension on Row {
  Row applyBorder({
    double? height,
    List<int>? flexIndex,
    required BoxDecoration boxDecoration,
  }) {
    List<Widget> borderedChildren = [];
    int i = 0;
    for (var child in children) {
      borderedChildren.add(
        Flexible(
          flex: flexIndex?[i] ?? 1,
          child: Container(
            alignment: Alignment.center,
            height: height,
            decoration: boxDecoration,
            padding: EdgeInsets.zero,
            child: child,
          ),
        ),
      );
      i++;
    }
    return Row(
      children: borderedChildren,
    );
  }

  Row applyFlexible({
    List<int>? flexIndex,
  }) {
    List<Widget> flexedWidget = [];
    int i = 0;
    for (var child in children) {
      flexedWidget.add(
        Flexible(
          flex: flexIndex?[i] ?? 1,
          child: child,
        ),
      );
      i++;
    }

    return Row(
      children: flexedWidget,
    );
  }

  Row applyExpanded({
    List<int>? flexIndex,
  }) {
    List<Widget> expandedWidget = [];
    int i = 0;
    for (var child in children) {
      expandedWidget.add(
        Expanded(
          flex: flexIndex?[i] ?? 1,
          child: child,
        ),
      );
      i++;
    }

    return Row(
      children: expandedWidget,
    );
  }
}
