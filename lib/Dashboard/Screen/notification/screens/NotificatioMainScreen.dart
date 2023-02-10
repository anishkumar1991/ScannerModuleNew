import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';

import 'CircularScreen.dart';
import 'NotificationScreen.dart';
import 'ReportScreen.dart';

class NotificationMainScreen extends StatefulWidget {
  const NotificationMainScreen({Key? key}) : super(key: key);

  @override
  State<NotificationMainScreen> createState() => _NotificationMainScreenState();
}

class _NotificationMainScreenState extends State<NotificationMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              "assets/images/notificationBackIcon.png",
              height: 16.74,
              width: 20,
            )),
        title: Text("Notification",
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColor.notificationTextColor)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, right: 20),
            child: InkWell(
              onTap: () async {
                DateTime? datePicked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                    lastDate: DateTime.now());

                print(datePicked.toString());
              },
              child: Container(
                  child: Row(
                    children: [
                      SizedBox(width: 16),
                      Image.asset(
                        "assets/images/notificationDateIcon.png",
                        width: 12,
                        height: 13.33,
                      ),
                      SizedBox(width: 9),
                      Text(
                        "Filter by Date",
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333)),
                      ),
                      SizedBox(width: 14),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xFFD5EDFA),
                      borderRadius: BorderRadius.all(Radius.circular(8)))),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, right: 12, left: 12),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  TabBar(
                    unselectedLabelColor: Color(0xFF666666),
                    indicatorWeight: 2,
                    indicator: BoxDecoration(
                      color: Color(0xFF447EFF),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    controller: tabController,
                    tabs: [
                      Tab(
                        child: Text(
                          "Circular",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Report",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Notification",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  CircularScreen(),
                  ReportScreen(),
                  NotificationScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}