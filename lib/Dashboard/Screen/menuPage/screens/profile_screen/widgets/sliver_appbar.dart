import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../../Values/app_colors.dart';
import '../../../../../../Values/icons.dart';
import 'header_widget_profile_screen.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Stack(
          children: [
            SizedBox(
              child: Stack(
                children: [
                  const Text("heello"),
                  Image.asset(AppIcons.profileBack,fit: BoxFit.cover),
                  Stack(
                    children: [
                      Positioned(
                          top: MediaQuery.of(context).size.height * 0.05,
                          right: MediaQuery.of(context).size.width * 0.2,
                          left: MediaQuery.of(context).size.width * 0.2,
                          child: Image.asset(AppIcons.circle1)),
                      Positioned(
                          top: MediaQuery.of(context).size.height * 0.06,
                          right: MediaQuery.of(context).size.width * 0.22,
                          left: MediaQuery.of(context).size.width * 0.22,
                          child: Image.asset(AppIcons.circle2)),
                      Positioned(
                          top: MediaQuery.of(context).size.height * 0.10,
                          right: MediaQuery.of(context).size.width * 0.22,
                          left: MediaQuery.of(context).size.width * 0.22,
                          child: Image.asset(AppIcons.rect)),
                      Positioned(
                          top: MediaQuery.of(context).size.height * 0.165,
                          right: MediaQuery.of(context).size.width * 0.3,
                          left: MediaQuery.of(context).size.width * 0.3,
                          child: Image.asset(AppIcons.textLogo)),
                      Positioned(
                          top: MediaQuery.of(context).size.height * 0.115,
                          right: MediaQuery.of(context).size.width * 0.45,
                          left: MediaQuery.of(context).size.width * 0.45,
                          child: Image.asset(AppIcons.bjpLogo)),
                    ],
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.21,
                      right: MediaQuery.of(context).size.width * 0.35,
                      left: MediaQuery.of(context).size.width * 0.01,
                      child: Image.asset(AppIcons.blueRound,height: 20,width: 20,)),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.247,
                      right: MediaQuery.of(context).size.width * 0.45,
                      left: MediaQuery.of(context).size.width * 0.01,
                      child: Image.asset(AppIcons.blueRound,height: 10,width: 10,)),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.215,
                      right: MediaQuery.of(context).size.width * 0.7,
                      left: MediaQuery.of(context).size.width * 0.00,
                      child: Image.asset(AppIcons.blueRound,height: 12,width: 12,)),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.21,
                      right: MediaQuery.of(context).size.width * 0.035,
                      left: MediaQuery.of(context).size.width * 0.36,
                      child: Image.asset(AppIcons.orangeRound,height: 14,width: 14,)),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.2,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  height: 110,
                  child: Stack(
                    children: [
                      CircularPercentIndicator(
                        radius: 50,
                        progressColor: AppColor.progressGreenColor,
                        percent: 0.84,
                        center: Image.asset(
                          AppIcons.userLogo,
                          height: 84,
                        ),
                        backgroundColor: AppColor.greyColor.withOpacity(0.3),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 28,
                        right: 28,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.white),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 2, bottom: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColor.progressGreenColor),
                            child: Text(
                              '82%',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: AppColor.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.28,
                right: MediaQuery.of(context).size.width * 0.38,
                left: MediaQuery.of(context).size.width * 0.03,
                child: Image.asset(AppIcons.blueRound,height: 13,width: 13,)),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.255,
                right: MediaQuery.of(context).size.width * 0.03,
                left: MediaQuery.of(context).size.width * 0.45,
                child: Image.asset(AppIcons.orangeRound,height: 10,width: 10,)),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.29,
                right: MediaQuery.of(context).size.width * 0.04,
                left: MediaQuery.of(context).size.width * 0.38,
                child: Image.asset(AppIcons.orangeRound,height: 12,width: 12,)),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.27,
                right: MediaQuery.of(context).size.width * 0.00,
                left: MediaQuery.of(context).size.width * 0.55,
                child: Image.asset(AppIcons.orangeRound,height: 20,width: 20,)),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.02,
                child: headerWidgetProfileScreen(context)),
          ],
        ),
      ],
    );
  }
}