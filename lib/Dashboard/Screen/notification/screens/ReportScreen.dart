import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/notification/cubit/NotificationState.dart';
import '../cubit/NotificationCubit.dart';
import '../widgets/FileTypeIcons.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var time = null;
    var temptimeshow;
    final cubit = context.read<NotificationCubit>();
    cubit.fetchNotification();

    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state is NotificationFetchingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is NotificationErrorState) {
          return Center(
            child: Text(
              state.error,
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600, fontSize: 20),
            ),
          );
        }
        if (state is NotificationFetchedState) {
          return Column(
            children: [
              const Divider(
                color: Color(0xFF979797),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15, top: 15),
              //   child: Row(
              //     children: [
              //       Text(
              //         "Today",
              //         style: GoogleFonts.quicksand(
              //             fontWeight: FontWeight.w600,
              //             fontSize: 14,
              //             color: const Color(0xFF2F2F2F)),
              //       ),
              //       Text(
              //         " - Monday, Jan 23",
              //         style: GoogleFonts.quicksand(
              //             fontWeight: FontWeight.w600,
              //             fontSize: 14,
              //             color: const Color(0xFF666666)),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 10),
              BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationFetchedState) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cubit.tempModel!.notificationsList?.length,
                        itemBuilder: (context, index) {
                          time =
                              cubit.tempModel!.notificationsList![index].time;
                          var temptime = time.split(":");

                          if (int.parse(temptime[0]) >= 12) {
                            if (int.parse(temptime[1]) > 0) temptimeshow = "PM";
                          } else {
                            temptimeshow = "AM";
                          }
                          var showtime = temptime[0] +
                              ":" +
                              temptime[1] +
                              " " +
                              temptimeshow;

                          if (cubit
                                  .tempModel!.notificationsList![index].sType ==
                              "report") {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: CustomFileIcon(
                                      FileType: cubit
                                          .tempModel!
                                          .notificationsList![index]
                                          .uploadFile),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        showtime.toString(),
                                        style: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: const Color(0xFF262626)),
                                      ),
                                      Text(
                                        cubit
                                            .tempModel!
                                            .notificationsList![index]
                                            .notificationTitle
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: const Color(0xFF262626)),
                                      ),
                                      const SizedBox(height: 4),
                                    ],
                                  ),
                                  subtitle: Text(
                                    cubit.tempModel!.notificationsList![index]
                                        .description
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: const Color(0xFF999999)),
                                  ),
                                ),
                                const Divider(
                                  endIndent: 20,
                                  indent: 20,
                                  color: Color(0xFF979797),
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    );
                  }
                  return const Text("fetching");
                },
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
