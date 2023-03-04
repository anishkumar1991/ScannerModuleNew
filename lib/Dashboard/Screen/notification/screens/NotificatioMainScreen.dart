import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';

import '../../../../generated/l10n.dart';
import '../cubit/DatePicCubit.dart';
import '../cubit/DatePicState.dart';
import '../cubit/NotificationCubit.dart';
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
  String? showtab;

  @override
  void initState() {
    fetchNotification();
    final cubit = context.read<NotificationCubit>();

    if (cubit.tempModel?.isCircularShow == false &&
        cubit.tempModel?.isReportShow == true) {
      tabController = TabController(length: 2, vsync: this);
      showtab = "Report";
    } else if (cubit.tempModel?.isCircularShow == true &&
        cubit.tempModel?.isReportShow == false) {
      tabController = TabController(length: 2, vsync: this);
      showtab = "Circular";
    } else if (cubit.tempModel?.isCircularShow == false &&
        cubit.tempModel?.isReportShow == false) {
      showtab = "Notification";
    } else {
      tabController = TabController(length: 3, vsync: this);
      showtab = "All";
    }
    super.initState();

    // tabController = TabController(length: 3, vsync: this);
  }

  Future<void> fetchNotification() async {
    final cubit = context.read<NotificationCubit>();
    await cubit.fetchNotification();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DatePicCubit>();
    return Scaffold(
        backgroundColor: Colors.white,
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
          title: Text(S.of(context).notification,
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColor.notificationTextColor)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, right: 10),
              child: BlocBuilder<DatePicCubit, DatePicState>(
                builder: (context1, state) {
                  if (state is DatePickedStateState) {
                    return InkWell(
                      onTap: () async {
                        DateTime? datePicked = await showDatePicker(
                            context: context1,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime.now());
                        cubit.datePicked(datePicked);
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFFD5EDFA),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Row(
                            children: [
                              const SizedBox(width: 16),
                              Image.asset(
                                "assets/images/notificationDateIcon.png",
                                width: 12,
                                height: 13.33,
                              ),
                              const SizedBox(width: 9),
                              Text(
                                S.of(context).notificationDate,
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF333333)),
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubit.dateRemoved();
                                  },
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                  ))
                            ],
                          )),
                    );
                  }
                  return InkWell(
                    onTap: () async {
                      DateTime? datePicked = await showDatePicker(
                          context: context1,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime.now());

                      cubit.datePicked(datePicked);
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Color(0xFFD5EDFA),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Image.asset(
                              "assets/images/notificationDateIcon.png",
                              width: 12,
                              height: 13.33,
                            ),
                            const SizedBox(width: 9),
                            Text(
                              S.of(context).notificationDate,
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF333333)),
                            ),
                            const SizedBox(width: 14),
                          ],
                        )),
                  );
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, right: 12, left: 12),
          child: showtab == "All"
              ? Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.5),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: TabBar(
                              unselectedLabelColor: const Color(0xFF666666),
                              indicator: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              controller: tabController,
                              tabs: [
                                Tab(
                                  child: Text(
                                    S.of(context).circular,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    S.of(context).report,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    S.of(context).notification,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: const [
                          CircularScreen(),
                          ReportScreen(),
                          NotificationScreen(),
                        ],
                      ),
                    )
                  ],
                )
              : showtab == "Circular"
                  ? Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black12, width: 1.5),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3),
                                child: TabBar(
                                  unselectedLabelColor: const Color(0xFF666666),
                                  indicator: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  controller: tabController,
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        S.of(context).circular,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    // Tab(
                                    //   child: Text(
                                    //     S.of(context).report,
                                    //     style: GoogleFonts.poppins(
                                    //         fontSize: 14,
                                    //         fontWeight: FontWeight.w600),
                                    //   ),
                                    // ),
                                    Tab(
                                      child: Text(
                                        S.of(context).notification,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: const [
                              CircularScreen(),
                              // ReportScreen(),
                              NotificationScreen(),
                            ],
                          ),
                        )
                      ],
                    )
                  : showtab == "Report"
                      ? Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black12, width: 1.5),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: TabBar(
                                      unselectedLabelColor:
                                          const Color(0xFF666666),
                                      indicator: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      controller: tabController,
                                      tabs: [
                                        Tab(
                                          child: Text(
                                            S.of(context).report,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            S.of(context).notification,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: tabController,
                                children: const [
                                  ReportScreen(),
                                  NotificationScreen(),
                                ],
                              ),
                            )
                          ],
                        )
                      : showtab == "Notification"
                          ? const NotificationScreen()
                          : const SizedBox(),
        ),
      );

  }
}
