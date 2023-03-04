import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Values/app_colors.dart';
import '../../../../Values/icons.dart';
import '../../../../generated/l10n.dart';
import '../../../../route/route_path.dart';
import '../../../../splash_screen/cubit/user_profile_cubit.dart';
import '../../../../splash_screen/cubit/user_profile_state.dart';
import '../../notification/screens/NotificatioMainScreen.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (() {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const NotificationMainScreen();
                  },
                ));
              }),
              child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.greyColor.withOpacity(0.1)),
                  child: const Icon(
                    Icons.notifications,
                    color: AppColor.greyColor,
                    size: 20,
                  )),
            ),
            Text(
              S.of(context).socialMedia,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutePath.profileScreen);
              },
              child: BlocBuilder<UserProfileCubit, UserProfileState>(
                builder: (context, state) {
                  return Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.dividerColor)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(350),
                      child: userProfileModel.data?.avatar != null &&
                              userProfileModel.data?.avatar != ''
                          ? Image.network(
                              userProfileModel.data?.avatar ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return const Icon(Icons.person, size: 25);
                              },
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            )
                          : Image.asset(AppIcons.userProfilePlaceholder),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
