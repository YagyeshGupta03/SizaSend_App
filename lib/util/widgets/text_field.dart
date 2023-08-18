import 'package:flutter/material.dart';
import 'package:savo/Constants/sizes.dart';
import 'package:savo/Controllers/global_controllers.dart';

import '../../Constants/theme_data.dart';
import '../../Helper/validate_helper.dart';
import '../../generated/l10n.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {Key? key,
      required this.topTitle,
      required this.keyboardType,
      required this.prefixWidget,
      required this.suffixWidget,
      required this.cont})
      : super(key: key);

  final String topTitle;
  final TextInputType keyboardType;
  final Widget prefixWidget;
  final Widget suffixWidget;
  final TextEditingController cont;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          widget.topTitle,
          style: themeController.currentTheme.value.textTheme.bodySmall,
        ),
        SizedBox(
          height: screenHeight(context) * .01,
        ),
        TextFormField(
          controller: widget.cont,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
              fillColor: themeController.currentTheme.value.cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: widget.prefixWidget,
              suffixIcon: widget.suffixWidget),
        ),
      ],
    );
  }
}
//
//
//
//
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.cont,
    required this.title,
    required this.icon,
    required this.fieldLabel,
    required this.keyboard,
    required this.fillColor,
    this.enable, required this.hintText,
  }) : super(key: key);

  final TextEditingController cont;
  final String title;
  final Widget icon;
  final bool? enable;
  final String fieldLabel;
  final String hintText;
  final TextInputType keyboard;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return Column( crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: themeController.currentTheme.value.textTheme.displayMedium,
        ),
        const SizedBox(height: 10),
        TextFormField(
          style: themeController.currentTheme.value.textTheme.displayMedium,
          cursorColor: primaryColor,
          controller: cont,
          keyboardType: keyboard,
          enabled: enable,
          validator: (value) => validateField(value!, fieldLabel, context),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            suffixIcon: icon,
            filled: true,
            fillColor: fillColor,
            hintText: hintText,
            hintStyle: themeController.currentTheme.value.textTheme.displayMedium,
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          ),
        ),
      ],
    );
  }
}
