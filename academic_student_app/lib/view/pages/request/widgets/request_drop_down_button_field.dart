import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/colors.dart';

class RequestDropDownField extends StatefulWidget {
  const RequestDropDownField({
    super.key,
    required this.fieldTitle,
    required this.fieldHint,
    required this.items,
    required this.setValue,
  });

  final String? Function(String?) setValue;
  final String fieldTitle;
  final String fieldHint;
  final List<DropdownMenuItem> items;

  @override
  State<RequestDropDownField> createState() => _RequestDropDownFieldState();
}

class _RequestDropDownFieldState extends State<RequestDropDownField> {
  String? value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.fieldTitle,
          style: GoogleFonts.tajawal(
            color: primaryColor,
          ),
        ),
        Container(
          height: 40,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(
              color: grey,
              width: 1,
            ),
          ),
          child: DropdownButton(
            value: value,
            hint: Text(widget.fieldHint),
            items: widget.items,
            isExpanded: true,
            underline: const SizedBox(),
            onChanged: (changedValue) {
              setState(() {
                value = widget.setValue(changedValue);
              });
            },
          ),
        ),
      ],
    );
  }
}
