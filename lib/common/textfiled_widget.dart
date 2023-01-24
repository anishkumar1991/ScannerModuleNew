import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Values/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
        required this.controller,
        required this.title,
        this.suffixWidget,
        this.keyboardType,
        this.readOnly,
        this.labelText,
        this.onTap,
        this.hintText});

  final TextEditingController controller;
  final String title;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final GestureTapCallback? onTap;
  final String? hintText;
  final String? labelText;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextField(
          controller: controller,
          readOnly: readOnly ?? false,
          keyboardType: keyboardType,
          clipBehavior: Clip.hardEdge,
          onTap: onTap,
          decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              labelStyle: GoogleFonts.poppins(
                  color: AppColor.naturalBlackColor,fontSize: 14),
              suffixIcon: suffixWidget),
        ),
      ],
    );
  }
}