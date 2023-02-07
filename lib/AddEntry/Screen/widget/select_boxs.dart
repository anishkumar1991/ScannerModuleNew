import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';

class SelectPropertyBox extends StatelessWidget {
  SelectPropertyBox(
      {super.key,
      required this.value,
      required this.title,
      required this.onChanged});

  bool value = false;
  String title;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColor.progressGreenColor,
        ),
        Text(
          title,
          style: GoogleFonts.quicksand(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.greyColor),
        ),
      ],
    );
  }
}
