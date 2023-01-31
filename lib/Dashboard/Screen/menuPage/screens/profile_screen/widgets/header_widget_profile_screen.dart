import 'package:flutter/material.dart';
import 'package:sangathan/Values/app_colors.dart';

import '../../../../../../Values/space_width_widget.dart';
import '../../../../../../common/appstyle.dart';
import '../../../../../../generated/l10n.dart';

Widget headerWidgetProfileScreen(BuildContext context) {
  return Row(
    children: [
      InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, size: 25,color: AppColor.white,)),
      spaceWidthWidget(10),
      Text(
        S.of(context).profile,
        style: textStyleWithPoppin(fontSize: 16,color: AppColor.white,fontWeight: FontWeight.w400),
      )
    ],
  );
}