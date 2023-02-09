import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/widgets/header_widget_edit_shakti_kendra.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/widgets/mandal_bottomSheet.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/widgets/select_booth.dart';
import 'package:sangathan/Dashboard/Screen/homePage/screens/shakti_kendra/screen/widgets/vidhanSabha_bottomSheet.dart';
import '../../../../../../Values/app_colors.dart';
import '../../../../../../Values/icons.dart';
import '../../../../../../Values/space_height_widget.dart';
import '../../../../../../common/common_button.dart';
import '../../../../../../generated/l10n.dart';
import 'cubit/edit_shakti_kendr_cubit.dart';

class EditShaktiKendraScreen extends StatefulWidget {
  bool? isEdit;
  String? vidhanSabhaName;
  String? mandalName;
  String? shaktiKendrName;
  int? vidhanSabhaId;
  int? shaktiKendrId;
  List<int>? boothId;

  EditShaktiKendraScreen(
      {Key? key,
      this.isEdit = false,
      this.vidhanSabhaId,
      this.vidhanSabhaName,
      this.shaktiKendrName,
      this.mandalName,
      this.shaktiKendrId,
      this.boothId})
      : super(key: key);

  @override
  State<EditShaktiKendraScreen> createState() => _EditShaktiKendraScreenState();
}

class _EditShaktiKendraScreenState extends State<EditShaktiKendraScreen> {
  void initState() {
    apiCall();
    super.initState();
  }

  apiCall() {
    if (widget.isEdit == true) {
      context.read<EditShaktiKendrCubit>().zilaSelected =
          widget.vidhanSabhaName ?? '';
      context.read<EditShaktiKendrCubit>().zilaId = widget.vidhanSabhaId ?? 236;
      context.read<EditShaktiKendrCubit>().shaktiKendrCtr.text =
          widget.shaktiKendrName ?? '';
      context.read<EditShaktiKendrCubit>().mandalSelected =
          widget.mandalName ?? '';
      context.read<EditShaktiKendrCubit>().chekedValue = widget.boothId ?? [];
      context.read<EditShaktiKendrCubit>().shaktiKendrId =
          widget.shaktiKendrId ?? 0;

      context
          .read<EditShaktiKendrCubit>()
          .getDropDownValueOfmandal(id: widget.vidhanSabhaId ?? 236);
      context
          .read<EditShaktiKendrCubit>()
          .getBoothValuew(id: widget.vidhanSabhaId ?? 236);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EditShaktiKendrCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              spaceHeightWidget(10),
              headerWidgetEditShaktiKendra(context),
              spaceHeightWidget(MediaQuery.of(context).size.height * 0.02),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      BlocBuilder<EditShaktiKendrCubit, EditShaktiKendrState>(
                        builder: (context, state) {
                          return ListTile(
                            horizontalTitleGap: 8,
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                  builder: (builder) {
                                    return VidhanSabhaBottomSheet(
                                        cubit: cubit,
                                        text: S.of(context).vidhanSabha,
                                        context: context);
                                  });
                            },
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              height: 47,
                              width: 47,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                    colors: [
                                      AppColor.purple50,
                                      AppColor.orange200,
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              child: Image.asset(AppIcons.vidhanSabha),
                            ),
                            title: Text(
                              S.of(context).vidhanSabha,
                              style: GoogleFonts.poppins(
                                  color: AppColor.black700,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            subtitle: Text(
                              cubit.zilaSelected == ""
                                  ? S.of(context).vidhanSabha
                                  : cubit.zilaSelected,
                              style: GoogleFonts.poppins(
                                  color: AppColor.black700,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            trailing: const SizedBox(
                              height: double.infinity,
                              child: Icon(
                                Icons.expand_more,
                                color: AppColor.textBlackColor,
                                size: 24,
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        color: AppColor.black,
                        thickness: 1,
                      ),
                      spaceHeightWidget(10),
                      ListTile(
                          horizontalTitleGap: 8,
                          tileColor: AppColor.pravasCradColor.withOpacity(0.2),
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          dense: true,
                          contentPadding: const EdgeInsets.only(left: 5),
                          leading: Container(
                            height: 47,
                            width: 47,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                  colors: [
                                    AppColor.purple50,
                                    AppColor.orange200,
                                  ],
                                  begin: FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: Image.asset(AppIcons.vidhanSabha),
                          ),
                          title: Text(
                            S.of(context).enterShaktiKendrName,
                            style: GoogleFonts.poppins(
                                color: AppColor.black700,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                          subtitle: SizedBox(
                            height: 20,
                            child: TextField(
                              controller: cubit.shaktiKendrCtr,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  hintText: S.of(context).shaktikendr,
                                  isDense: true),
                            ),
                          )),
                      spaceHeightWidget(10),
                      BlocBuilder<EditShaktiKendrCubit, EditShaktiKendrState>(
                        builder: (context, state) {
                          return ListTile(
                            horizontalTitleGap: 8,
                            onTap: () async {
                              if (context
                                      .read<EditShaktiKendrCubit>()
                                      .zilaSelected ==
                                  '') {
                                EasyLoading.showToast(
                                    "Please Select Vidhansabha first",
                                    toastPosition:
                                        EasyLoadingToastPosition.top);
                              } else {
                                await showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28.0),
                                    ),
                                    builder: (builder) {
                                      return MandalBottomSheet(
                                          cubit: cubit,
                                          context: context,
                                          text: S.of(context).mandal);
                                    });
                              }
                            },
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              height: 47,
                              width: 47,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                    colors: [
                                      AppColor.purple50,
                                      AppColor.orange200,
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              child: Image.asset(AppIcons.mandal),
                            ),
                            title: Text(
                              S.of(context).mandal,
                              style: GoogleFonts.poppins(
                                  color: AppColor.black700,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            subtitle: Text(
                              cubit.mandalSelected == ''
                                  ? S.of(context).mandal
                                  : cubit.mandalSelected,
                              style: GoogleFonts.poppins(
                                  color: AppColor.black700,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            trailing: const SizedBox(
                              height: double.infinity,
                              child: Icon(
                                Icons.expand_more,
                                color: AppColor.textBlackColor,
                                size: 24,
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        color: AppColor.black,
                        thickness: 1,
                      ),
                      spaceHeightWidget(10),
                      BlocBuilder<EditShaktiKendrCubit, EditShaktiKendrState>(
                        builder: (context, state) {
                          return ListTile(
                            horizontalTitleGap: 8,
                            onTap: () {
                              if (context
                                      .read<EditShaktiKendrCubit>()
                                      .zilaSelected ==
                                  '') {
                                EasyLoading.showToast(
                                    "Please Select Vidhansabha first",
                                    toastPosition:
                                        EasyLoadingToastPosition.top);
                              } else {
                                showModalBottomSheet(
                                    context: context,
                                    backgroundColor: AppColor.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    builder: (builder) {
                                      return SelectBooth(cubit: cubit);
                                    });
                              }
                            },
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              height: 47,
                              width: 47,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                    colors: [
                                      AppColor.purple50,
                                      AppColor.orange200,
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              child: Image.asset(AppIcons.booth),
                            ),
                            title: Text(
                              S.of(context).buth,
                              style: GoogleFonts.poppins(
                                  color: AppColor.black700,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            subtitle: cubit.chekedValue.isEmpty
                                ? Text(
                                    S.of(context).buth,
                                    style: GoogleFonts.poppins(
                                        color: AppColor.black700,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  )
                                : SizedBox(
                                    height: 25,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: cubit.chekedValue.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Text(
                                                cubit.chekedValue[index]
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    color: AppColor.black700,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                              ),
                                              index + 1 ==
                                                      cubit.chekedValue.length
                                                  ? const SizedBox.shrink()
                                                  : Text(
                                                      ", ",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: AppColor
                                                                  .black700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14),
                                                    ),
                                            ],
                                          );
                                        }),
                                  ),
                            trailing: const SizedBox(
                              height: double.infinity,
                              child: Icon(
                                Icons.expand_more,
                                color: AppColor.textBlackColor,
                                size: 24,
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        color: AppColor.black,
                        thickness: 1,
                      ),
                      // widget.isEdit ?? false
                      //     ? Column(
                      //         children: [
                      //           spaceHeightWidget(10),
                      //           Align(
                      //             alignment: Alignment.centerLeft,
                      //             child: Text(
                      //               S.of(context).selectedBooth,
                      //               style: GoogleFonts.poppins(
                      //                   color: AppColor.naturalBlackColor,
                      //                   fontSize: 16,
                      //                   fontWeight: FontWeight.w500),
                      //             ),
                      //           ),
                      //           spaceHeightWidget(10),
                      //           SelectedBooth(
                      //               title: 'Govt. Senior Secondary Girls High',
                      //               subTitle: "High School",
                      //               leadingText: '102',
                      //               onClose: () {}),
                      //           spaceHeightWidget(20),
                      //           Align(
                      //             alignment: Alignment.centerLeft,
                      //             child: Text(
                      //               S.of(context).boothSelectedTitle,
                      //               style: GoogleFonts.poppins(
                      //                   color: AppColor.black.withOpacity(0.7),
                      //                   fontSize: 16,
                      //                   fontWeight: FontWeight.w500),
                      //             ),
                      //           ),
                      //           spaceHeightWidget(5),
                      //           Align(
                      //             alignment: Alignment.centerLeft,
                      //             child: Text(
                      //               S.of(context).boothDes,
                      //               style: GoogleFonts.poppins(
                      //                   color: AppColor.naturalBlackColor
                      //                       .withOpacity(0.7),
                      //                   fontSize: 13),
                      //             ),
                      //           ),
                      //           spaceHeightWidget(10),
                      //           const WarningBooth()
                      //         ],
                      //       )
                      //     : const SizedBox.shrink()
                    ],
                  ),
                ),
              ),
              spaceHeightWidget(15),
              CommonButton(
                  borderRadius: 15,
                  onTap: () async {
                    cubit.emitState();
                    if (cubit.zilaSelected == "") {
                      EasyLoading.showToast("Please select vidhanSabha",
                          toastPosition: EasyLoadingToastPosition.top);
                    } else if (cubit.shaktiKendrCtr.text.isEmpty) {
                      EasyLoading.showToast("Please enter shakti kendr name",
                          toastPosition: EasyLoadingToastPosition.top);
                    } else if (cubit.mandalSelected == "") {
                      EasyLoading.showToast("Please select mandal",
                          toastPosition: EasyLoadingToastPosition.top);
                    } else {
                      await cubit.createAndEditShaktiKendr(
                          context: context,
                          skName: cubit.shaktiKendrCtr.text,
                          vidhanSabhaId: cubit.zilaId,
                          mandalId: cubit.mandalId,
                          booth: cubit.selectedBooth,
                          isEdit: widget.isEdit);
                      Future.delayed(Duration.zero).then((value) {
                        Navigator.pop(context);
                      });
                    }
                  },
                  title: widget.isEdit ?? false
                      ? S.of(context).submit
                      : S.of(context).makeShaktikendr,
                  width: MediaQuery.of(context).size.width * 0.6,
                  style:
                  GoogleFonts.poppins(color: AppColor.white, fontSize: 14),
                  padding: const EdgeInsets.symmetric(vertical: 10)),
              spaceHeightWidget(15),
            ],
          ),
        ),
      ),
    );
  }

  bottom(
      {required BuildContext context,
      required EditShaktiKendrCubit cubit,
      required String selectedVar,
      required List list,
      required String text}) {
    return Container(
      color: Colors.transparent,
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.0),
                  topRight: Radius.circular(28.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceHeightWidget(10),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 5,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColor.borderColor),
                  ),
                ),
                spaceHeightWidget(30),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: AppColor.borderColor, fontSize: 16),
                ),
                spaceHeightWidget(30),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                selectedVar = list[index];
                                cubit.emitState();
                                Navigator.pop(context, selectedVar);
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  list[index] ?? '',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      color: AppColor.black, fontSize: 16),
                                ),
                              ),
                            ),
                            spaceHeightWidget(15),
                            const Divider(
                              color: AppColor.borderColor,
                            ),
                            spaceHeightWidget(15),
                          ],
                        );
                      }),
                )
              ],
            ),
          )),
    );
  }
}
