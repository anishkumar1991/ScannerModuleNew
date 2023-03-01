import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Storage/user_storage_service.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/Values/space_width_widget.dart';
import 'package:sangathan/route/route_path.dart';
import 'package:sangathan/splash_screen/cubit/user_profile_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../../../common/appstyle.dart';
import '../../../generated/l10n.dart';
import '../../../splash_screen/cubit/user_profile_cubit.dart';
import 'cubit/menu_screen_cubit.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  final texteditingcontroller = TextEditingController();

  @override
  void initState() {
    context.read<MenuScreenCubit>().getSupportNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              BlocBuilder<UserProfileCubit, UserProfileState>(
                builder: (context, state) {
                  if (state is UserProfileDataFetchedState) {
                    userProfileModel = state.userProfileModel;
                  }
                  return ListTile(
                    minLeadingWidth: 5,
                    onTap: () {
                      Navigator.pushNamed(context, RoutePath.profileScreen);
                    },
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      userProfileModel.data?.name != null
                          ? "${S.of(context).welcome} ${userProfileModel.data?.name}"
                          : S.of(context).welcome,
                      overflow: TextOverflow.ellipsis,
                      style: textStyleWithPoppin(
                          fontSize: 15,
                          color: AppColor.black,
                          fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      userProfileModel.data?.username != null
                          ? "@${userProfileModel.data?.username}"
                          : "",
                      style: textStyleWithPoppin(
                          fontSize: 10,
                          color: AppColor.greyColor.withOpacity(0.7),
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                      color: AppColor.naturalBlackColor,
                    ),
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.dividerColor)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(350),
                        child: Image.network(
                          userProfileModel.data?.avatar ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Icon(Icons.person, size: 25);
                          },
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              spaceHeightWidget(15),
              /* GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InsightsMainPage()));
                },
                child: Container(
                  color: AppColor.greyColor.withOpacity(0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.greyColor.withOpacity(0.2),
                              ),
                              child: const Center(
                                child: Text(
                                  "#",
                                  style: TextStyle(fontSize: 25),
                                ),
                              )),
                          spaceWidthWidget(10),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              S.of(context).ThemeandInsight,
                              style: textStyleWithPoppin(
                                  fontSize: 14,
                                  color: AppColor.naturalBlackColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                size: 18, color: AppColor.naturalBlackColor),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.12,
                            right: 4),
                        child: Text(
                          S.of(context).ThemeDes,
                          style: textStyleWithPoppin(
                              color: AppColor.greyColor.withOpacity(0.7),
                              fontSize: 13),
                        ),
                      )
                    ],
                  ),
                ),
              ),*/
              //spaceHeightWidget(MediaQuery.of(context).size.height * 0.08),
              InkWell(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Account Deletion'),
                          content: const Text(
                              'After 15 days, your account will be permanently deleted; however, you can return and login to remain connected.'),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Details"),
                                      content: Text(S.of(context).welcome +
                                          " " +
                                          StorageService.getUserData()!
                                              .user!
                                              .name
                                              .toString() +
                                          "\n" +
                                          StorageService.getUserData()!
                                              .user!
                                              .phone
                                              .toString()),
                                      actions: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5, bottom: 20),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black12)),
                                            child: Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: TextFormField(

                                                decoration: const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Reason for deletion"),
                                                controller: texteditingcontroller,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge,
                                              ),
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge,
                                              ),
                                              child: const Text('OK'),
                                              onPressed: () {
                                                sendMail(StorageService
                                                        .getUserData()!
                                                    .user!
                                                    .name
                                                    .toString(),texteditingcontroller.text);
                                                Navigator.of(context).pop();
                                                showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Mail Sent Successfully"),
                                                      content: const Text(
                                                          "You account will be permanently deleted in 15 days"),
                                                      actions: <Widget>[

                                                        TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelLarge,
                                                          ),
                                                          child: const Text(
                                                              'OK'),
                                                          onPressed:
                                                              () async {
                                                                Navigator.of(context).pop();
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: customListTile(
                      title: "Request For Account Delete",
                      icon: AppIcons.clearIcon)),
              spaceHeightWidget(10),
              const Divider(
                color: AppColor.dividerColor,
              ),
              customListTile(title: "Support", icon: AppIcons.supportIcon),
              spaceHeightWidget(10),
              const Divider(
                color: AppColor.dividerColor,
              ),
              spaceHeightWidget(5),
              Align(
                  alignment: Alignment.centerLeft,
                  child: customBottomContainer())
            ])));
  }

  Widget customListTile({
    required String icon,
    required String title,
    double? height,
  }) {
    return Row(
      children: [
        Image.asset(
          icon,
          height: height ?? 22,
        ),
        spaceWidthWidget(10),
        Text(
          title,
          style: textStyleWithPoppin(
              color: AppColor.greyColor.withOpacity(0.7), fontSize: 15),
        ),
      ],
    );
  }

  Widget customBottomContainer() {
    return InkWell(
      onTap: () {
        if (context.read<MenuScreenCubit>().supportNumber != null) {
          _makePhoneCall(
              phoneNumber: "${context.read<MenuScreenCubit>().supportNumber}");
        }
      },
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.greyColor.withOpacity(0.4))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppIcons.customerService1,
              color: AppColor.greyColor.withOpacity(0.5),
              height: 22,
            ),
            spaceHeightWidget(5),
            Text(
              "Support",
              style: textStyleWithPoppin(
                  color: AppColor.greyColor.withOpacity(0.7), fontSize: 13),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall({required String phoneNumber}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future sendMail(String name, String text) async {
    String email = 'sangathantest@gmail.com';
    String token = 'ggovipygfzprffph';

    final smtpServer = gmail(email, token);
    final message = Message()
      ..from = Address(email, name)
      ..recipients = ['sangatanapp@gmail.com']
      ..subject = 'Account Deletion Request'
      ..text = text;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print(e.toString());
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
