import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangathan/Dashboard/Screen/menuPage/screens/edit_address/widgets/header_widget_edit_address_screen.dart';
import 'package:sangathan/Values/space_height_widget.dart';
import 'package:sangathan/Values/space_width_widget.dart';

import '../../../../../Values/app_colors.dart';
import '../../../../../Values/icons.dart';
import '../../../../../common/appstyle.dart';
import '../../../../../common/common_button.dart';
import '../../../../../common/textfiled_widget.dart';
import '../../../../../generated/l10n.dart';
import 'cubit/edit_address_cubit.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({Key? key}) : super(key: key);

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditAddressCubit>();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            spaceHeightWidget(5),
            headerWidgetEditAddress(context),
            spaceHeightWidget(10),
            Expanded(child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
              children: [
                BlocBuilder<EditAddressCubit,
                    EditAddressState>(
                  builder: (context, state) {
                    return   TextFieldWidget(
                      controller: cubit.flatDesCtr,
                      title: '',
                      labelText:  S.of(context).FlatDes,
                      onChanged: (value) {
                        cubit.emitState();
                      },
                      keyboardType: TextInputType.emailAddress,
                      suffixWidget: cubit.flatDesCtr.text.isNotEmpty
                          ? InkWell(
                        onTap: () {
                          cubit.flatDesCtr.clear();
                          cubit.emitState();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 15, right: 15),
                          child: Image.asset(
                            AppIcons.clearIcon,
                            height: 2,
                            width: 5,
                          ),
                        ),
                      )
                          : const SizedBox.shrink(),
                    );
                  },
                ),
                spaceHeightWidget(10),
                BlocBuilder<EditAddressCubit,
                    EditAddressState>(
                  builder: (context, state) {
                    return   TextFieldWidget(
                      controller: cubit.areaDesCtr,
                      title: '',
                      labelText:  S.of(context).AreaDes,
                      onChanged: (value) {
                        cubit.emitState();
                      },
                      keyboardType: TextInputType.emailAddress,
                      suffixWidget: cubit.areaDesCtr.text.isNotEmpty
                          ? InkWell(
                        onTap: () {
                          cubit.areaDesCtr.clear();
                          cubit.emitState();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 15, right: 15),
                          child: Image.asset(
                            AppIcons.clearIcon,
                            height: 2,
                            width: 5,
                          ),
                        ),
                      )
                          : const SizedBox.shrink(),
                    );
                  },
                ),
                spaceHeightWidget(10),
                BlocBuilder<EditAddressCubit,
                    EditAddressState>(
                  builder: (context, state) {
                    return   TextFieldWidget(
                      controller: cubit.pinCodeCtr,
                      title: '',
                      labelText:  S.of(context).PinCode,
                      onChanged: (value) {
                        cubit.emitState();
                      },
                      keyboardType: TextInputType.emailAddress,
                      suffixWidget: cubit.pinCodeCtr.text.isNotEmpty
                          ? InkWell(
                        onTap: () {
                          cubit.pinCodeCtr.clear();
                          cubit.emitState();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 15, right: 15),
                          child: Image.asset(
                            AppIcons.clearIcon,
                            height: 2,
                            width: 5,
                          ),
                        ),
                      )
                          : const SizedBox.shrink(),
                    );
                  },
                ),
                spaceHeightWidget(10),
                BlocBuilder<EditAddressCubit,
                    EditAddressState>(
                  builder: (context, state) {
                    return   TextFieldWidget(
                      controller: cubit.townCtr,
                      title: '',
                      labelText:  S.of(context).townCity,
                      onChanged: (value) {
                        cubit.emitState();
                      },
                      keyboardType: TextInputType.emailAddress,
                      suffixWidget: cubit.townCtr.text.isNotEmpty
                          ? InkWell(
                        onTap: () {
                          cubit.townCtr.clear();
                          cubit.emitState();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 15, right: 15),
                          child: Image.asset(
                            AppIcons.clearIcon,
                            height: 2,
                            width: 5,
                          ),
                        ),
                      )
                          : const SizedBox.shrink(),
                    );
                  },
                ),
                spaceHeightWidget(10),
                BlocBuilder<EditAddressCubit,
                    EditAddressState>(
                  builder: (context, state) {
                    return   TextFieldWidget(
                      controller: cubit.stateCtr,
                      title: '',
                      labelText:  S.of(context).state,
                      onChanged: (value) {
                        cubit.emitState();
                      },
                      keyboardType: TextInputType.emailAddress,
                      suffixWidget: cubit.stateCtr.text.isNotEmpty
                          ? InkWell(
                        onTap: () {
                          cubit.stateCtr.clear();
                          cubit.emitState();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 15, right: 15),
                          child: Image.asset(
                            AppIcons.clearIcon,
                            height: 2,
                            width: 5,
                          ),
                        ),
                      )
                          : const SizedBox.shrink(),
                    );
                  },
                ),
                spaceHeightWidget(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildBottomContainer(icon: Icons.home,title: S.of(context).home),
                    buildBottomContainer(image: AppIcons.fillBuisnessIcon,title: S.of(context).Office,isImage: true),
                    buildBottomContainer(icon: Icons.location_on,title: S.of(context).Other),
                  ],
                ),
                spaceHeightWidget(40),
                CommonButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: S.of(context).delete,
                  width: 150,
                  height: 20,
                  borderRadius: 25,
                  backGroundcolor: Colors.transparent,
                  bordercolor: Colors.transparent,
                  style: textStyleWithPoppin(color: AppColor.greyColor.withOpacity(0.3), fontSize: 14),
                ),
                spaceHeightWidget(5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(color: AppColor.dividerColor,),
                ),
                spaceHeightWidget(5),
                CommonButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: S.of(context).save,
                  width: 150,
                  height: 38,
                  borderRadius: 25,
                  style: textStyleWithPoppin(color: AppColor.white, fontSize: 16),
                ),
                spaceHeightWidget(15),
              ],
            ),))

          ],
        ),
      ),
    );
  }

  buildBottomContainer({IconData? icon,String? title,bool? isImage,String? image}){
    return           Container(
      height: MediaQuery.of(context).size.height * 0.04,
      width: MediaQuery.of(context).size.width * 0.28,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColor.black)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isImage ?? false ? Image.asset(image!,height: 20,width: 20,) : Icon(icon) ,
          spaceWidthWidget(5),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Text(title!,style: textStyleWithPoppin(color: AppColor.black, fontSize: 14),),
          )
        ],
      ),
    );
  }
}