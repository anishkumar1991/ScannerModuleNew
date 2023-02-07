import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/share/Share.dart';
import 'package:sangathan/Dashboard/Screen/socialMedia/posts/share/ShareOnWhatsapp.dart';
import 'cubit/FetchPostCubit.dart';
import 'cubit/ShareCubit.dart';
import 'cubit/ShareState.dart';

class BottomSocialBar extends StatelessWidget {
  final int index;

  const BottomSocialBar({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit1 = context.read<FetchPostsCubit>();
    final cubit2 = context.read<ShareCubit>();
    var id = cubit1.tempModel!.posts[index].id.toString();
    var shareToAllCount = cubit1.tempModel!.posts[index].shares.other;
    var shareToWhatsapp = cubit1.tempModel!.posts[index].shares.whatsapp;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              LikeButton(
                size: 40,
                circleColor: const CircleColor(
                    start: Color(0xff00ddff), end: Color(0xff0099cc)),
                bubblesColor: const BubblesColor(
                  dotPrimaryColor: Color(0xff33b5e5),
                  dotSecondaryColor: Color(0xff0099cc),
                ),
                likeCount: cubit1.tempModel!.posts[index].reactions[0].count,
                likeBuilder: (isTapped) {
                  isTapped ? cubit1.sendLike(id) : null;
                  return Icon(
                    Icons.thumb_up_alt,
                    color: isTapped ? Colors.blue : Colors.grey,
                  );
                },
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    cubit2.shareToAll(id);
                    share(context, index);
                  },
                  icon: const Icon(Icons.share_outlined)),
              BlocBuilder<ShareCubit, ShareState>(
                builder: (context, state) {
                  if (state is SharedToAll) {
                    shareToAllCount = shareToAllCount + 1;
                    return Text(shareToAllCount.toString());
                  }
                  return Text(shareToAllCount.toString());
                },
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                cubit2.shareToWhatsapp(id);
                shareOnWhatsapp(context, SocialMedia.whatsapp, index);
              },
              icon: const Icon(FontAwesomeIcons.whatsapp,
                  color: Color(0xFF1FAF38)),
            ),
            BlocBuilder<ShareCubit, ShareState>(
              builder: (context, state) {
                if (state is SharedToWhatsapp) {
                  shareToWhatsapp = shareToWhatsapp + 1;
                  return Text(shareToWhatsapp.toString());
                }
                return Text(shareToWhatsapp.toString());
              },
            ),
          ],
        ),
      ],
    );
  }
}
