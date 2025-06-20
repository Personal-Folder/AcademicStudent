import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:search_choices/search_choices.dart';

class RegisterDropDownSelector extends StatefulWidget {
  final String label;
  final List items;
  final Function(dynamic) changer;
  const RegisterDropDownSelector(
      {super.key,
      required this.label,
      required this.items,
      required this.changer});

  @override
  State<RegisterDropDownSelector> createState() =>
      RegisterDropDownSelectorState();
}

class RegisterDropDownSelectorState extends State<RegisterDropDownSelector> {
  dynamic selectedValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceBright,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(width: 2, color: Colors.black)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.label,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
          Expanded(
            child: SearchChoices.single(
                isExpanded: true,
                dialogBox: true,
                buildDropDownDialog: kIsWeb
                    ? (titleBar, searchBar, list, closeButton,
                            dropDownContext) =>
                        Dialog(
                          child: Container(
                            // color: Colors.grey.withOpacity(0.3),
                            height: 600,
                            width: 400,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 400,
                                  height: 80,
                                  color: Colors.white,
                                  child: searchBar,
                                ),
                                list,
                              ],
                            ),
                          ),
                        )
                    : null,
                displayClearIcon: false,
                rightToLeft: Get.locale == const Locale('ar'),
                padding: EdgeInsets.zero,
                underline: const SizedBox(),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                  widget.changer(value);
                },
                value: selectedValue,
                selectedValueWidgetFn: (value) {
                  final String selectedTitle = widget.items
                      .firstWhere((element) => element.id == value)
                      .name;
                  return SizedBox(
                    // height: 28,
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        selectedTitle,
                        maxLines: 1,
                        maxFontSize: 14,
                        minFontSize: 10,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  );
                },
                closeButton: null,
                searchFn: (String keyword, _) {
                  List<int> ret = [];
                  if (keyword.isNotEmpty) {
                    keyword.split(" ").forEach((k) {
                      int i = 0;
                      for (var item in widget.items) {
                        if (k.isNotEmpty &&
                            (item.name
                                .toString()
                                .toLowerCase()
                                .contains(k.toLowerCase()))) {
                          ret.add(i);
                        }
                        i++;
                      }
                    });
                  }
                  if (keyword.isEmpty) {
                    ret = Iterable<int>.generate(widget.items.length).toList();
                  }
                  return (ret);
                },
                items: widget.items
                    .map(
                      (e) => kIsWeb
                          ? DropdownMenuItem(
                              value: e.id,
                              alignment: Alignment.center,
                              child: Container(
                                width: 400,
                                height: 50,
                                alignment: Alignment.center,
                                color: Colors.white,
                                child: Text(
                                  e.name,
                                ),
                              ),
                            )
                          : DropdownMenuItem(
                              value: e.id,
                              child: Text(
                                e.name,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                            ),
                    )
                    .toList()),
          ),
        ],
      ),
    );
  }
}
