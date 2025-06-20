import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final bool? isPhoneNumber;
  final String hintText;
  final bool? isRequired;
  final TextEditingController controller;
  final Widget? leading;
  final int? maxLines;
  final int? maxLength;
  final bool? isObscure;
  final FormFieldValidator<String?>? validate;
  final Function()? onTap;

  const AppTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isPhoneNumber = false,
    this.validate,
    this.isObscure = false,
    this.maxLength,
    this.maxLines,
    this.onTap,
    this.leading,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        absorbing: onTap != null,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            controller: controller,
            validator: validate,
            obscureText: isObscure!,
            maxLength: maxLength,
            maxLines: maxLines,
            keyboardType:
                isPhoneNumber! ? TextInputType.phone : TextInputType.text,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: isRequired! ? '$hintText *' : hintText,
              prefixIcon: leading,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceBright,
              hintStyle: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(width: 2.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
