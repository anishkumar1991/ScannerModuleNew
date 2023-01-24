import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/AddEntry/Cubit/add_entry_cubit.dart';
import 'package:sangathan/AddEntry/Cubit/add_entry_state.dart';
import 'package:sangathan/AddEntry/Screen/widget/custom_radio_button.dart';
import 'package:sangathan/AddEntry/Screen/widget/custom_textfield.dart';
import 'package:sangathan/AddEntry/Screen/widget/drop_down_widget.dart';
import 'package:sangathan/AddEntry/Screen/widget/image_not_uploaded_widget.dart';
import 'package:sangathan/AddEntry/Screen/widget/select_boxs.dart';
import 'package:sangathan/AddEntry/Screen/widget/upload_file_widget.dart';
import 'package:sangathan/AddEntry/Screen/widget/user_image.dart';
import 'package:sangathan/common/textfiled_widget.dart';
import 'package:sangathan/AddEntry/Screen/widget/upload_file_widget.dart';
import 'package:sangathan/AddEntry/Screen/widget/user_image.dart';
import 'package:sangathan/common/common_button.dart';
import 'package:sangathan/Values/app_colors.dart';
import 'package:sangathan/Values/icons.dart';
import 'package:sangathan/Values/spaceHeightWidget.dart';
import 'package:sangathan/Values/spaceWidthWidget.dart';

import '../../common/common_button.dart';
import '../../common/textfiled_widget.dart';

class AddEntryPage extends StatefulWidget {
  AddEntryPage({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController castController = TextEditingController();
  TextEditingController mandalController = TextEditingController();
  TextEditingController nativeStateController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController soController = TextEditingController();
  TextEditingController fullAddressController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController whatsAppNoController = TextEditingController();
  TextEditingController alternatePhoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController adharNoController = TextEditingController();
  TextEditingController voterIDController = TextEditingController();
  TextEditingController rationCardNoController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController societyController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController streetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddEntryCubit>(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    splashRadius: 20,
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    icon: const Icon(Icons.arrow_back)),
                const Text(
                  'Add Entry',
                  style: TextStyle(
                      fontFamily: 'Tw Cen MT',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBlackColor),
                )
              ],
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceHeightWidget(14),
                    Center(
                      child: widget.type == 'Loksabha'
                          ? ImageNotUploaded(
                              onTap: (() {}),
                            )
                          : UserImageCard(
                              onTap: (() {}),
                              imageUrl: AppIcons.addUserImage,
                            ),
                    ),
                    spaceHeightWidget(20),
                    widget.type == 'Loksabha'
                        ? CustomDropDown(
                            title: 'Designation',
                            hintText: 'Select Designation',
                            dropDownList: const ['A', 'B', 'C', 'D'],
                          )
                        : CommonTextField(
                            keyboardType: TextInputType.name,
                            title: 'Name',
                            hintText: 'Enter Your Name',
                            controller: nameController,
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? TextFieldWidget(
                            controller: phoneController,
                            title: 'Mobile No',
                            keyboardType: TextInputType.phone,
                            hintText: 'Enter Your Mobile No')
                        : CommonTextField(
                            title: 'Phone No.',
                            hintText: 'Enter Your Phone Number',
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? TextFieldWidget(
                            controller: nameController,
                            title: 'Full Name',
                            hintText: 'Enter Full Name')
                        : CommonTextField(
                            title: 'Designation',
                            hintText: 'Enter Your Designation',
                            controller: designationController,
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? BlocBuilder<AddEntryCubit, AddEntryState>(
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomRadioButton(
                                    title: 'Male',
                                    value: 'male',
                                    groupValue: cubit.selectRadio ?? "",
                                  ),
                                  CustomRadioButton(
                                    title: 'Female',
                                    value: 'female',
                                    groupValue: cubit.selectRadio ?? "",
                                  ),
                                  CustomRadioButton(
                                    title: 'Transgender',
                                    value: 'transGender',
                                    groupValue: cubit.selectRadio ?? "",
                                  ),
                                ],
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? CustomDropDown(
                            title: 'Category',
                            hintText: 'Select Category',
                            dropDownList: const ['F', 'T', 'H', 'Y'],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: CommonTextField(
                                  title: 'DOB',
                                  hintText: 'Enter Your DOB',
                                  keyboardType: TextInputType.datetime,
                                  controller: dobController,
                                ),
                              ),
                              spaceWidthWidget(9),
                              Expanded(
                                child: CommonTextField(
                                  title: 'Category',
                                  hintText: 'Enter Category',
                                  controller: categoryController,
                                ),
                              ),
                            ],
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? CustomDropDown(
                            title: 'Cast',
                            hintText: 'Select Cast',
                            dropDownList: const ['OBC', 'General', 'SC', 'ST'],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: CommonTextField(
                                  title: 'Caste',
                                  hintText: 'Enter Your Cast',
                                  controller: castController,
                                ),
                              ),
                              spaceWidthWidget(9),
                              Expanded(
                                child: CommonTextField(
                                  title: 'Mandal',
                                  hintText: 'Enter Mandal Name',
                                  controller: mandalController,
                                ),
                              ),
                            ],
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? CustomDropDown(
                            title: 'Qualification',
                            hintText: 'Select Qualification',
                            dropDownList: const ['B.tech', 'M.A.', 'BCA', 'CA'],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: CommonTextField(
                                  title: 'Native State',
                                  hintText: 'Enter Your Native State',
                                  controller: nativeStateController,
                                ),
                              ),
                              spaceWidthWidget(9),
                              Expanded(
                                child: CommonTextField(
                                  title: 'Age',
                                  hintText: 'Enter Your Age',
                                  keyboardType: TextInputType.number,
                                  controller: ageController,
                                ),
                              ),
                            ],
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? CustomDropDown(
                            title: 'Profession',
                            hintText: 'Select Profession',
                            dropDownList: const ['Designer', 'Developer'],
                          )
                        : CommonTextField(
                            title: 'Gender',
                            hintText: 'Enter Your Gender',
                            controller: genderController,
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              spaceHeightWidget(5),
                              const Text('DOB'),
                              spaceHeightWidget(8),
                              BlocBuilder<AddEntryCubit, AddEntryState>(
                                builder: (context, state) {
                                  return Row(
                                    children: [
                                      Text(
                                        cubit.date,
                                        style: const TextStyle(
                                          color: AppColor.greyColor,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () async {
                                          cubit.selectedDoaDate(context);
                                        },
                                        child: const Icon(
                                            Icons.calendar_month_outlined),
                                      )
                                    ],
                                  );
                                },
                              ),
                              spaceHeightWidget(4),
                              const Divider(
                                height: 2,
                                thickness: 1.5,
                                color: AppColor.textBlackColor,
                              )
                            ],
                          )
                        : CommonTextField(
                            title: 'Address',
                            hintText: 'Enter Your Address',
                            controller: addressController,
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? TextFieldWidget(
                            controller: pinController,
                            title: 'Pin Code',
                            keyboardType: TextInputType.number,
                            hintText: 'Enter Pin Code')
                        : Row(
                            children: [
                              Expanded(
                                child: CommonTextField(
                                  title: 'Qualification',
                                  hintText: 'Enter Your Qualification',
                                  controller: qualificationController,
                                ),
                              ),
                              spaceWidthWidget(9),
                              Expanded(
                                child: CommonTextField(
                                  title: 'Profession',
                                  hintText: 'Enter Your Profession',
                                  controller: professionController,
                                ),
                              ),
                            ],
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? Column(
                            children: [
                              TextFieldWidget(
                                  controller: addressController,
                                  title: 'Adress',
                                  hintText: 'Enter Address'),
                              spaceHeightWidget(8),
                              TextFieldWidget(
                                  controller: mandalController,
                                  title: 'Mandal',
                                  hintText: 'Enter Mandal'),
                              spaceHeightWidget(8),
                              CustomDropDown(
                                title: 'Native State',
                                hintText: 'Select State',
                                dropDownList: const [
                                  'Gujarat',
                                  'MadhyaPradesh'
                                ],
                              )
                            ],
                          )
                        : const SizedBox.shrink(),
                    spaceHeightWidget(24),
                    widget.type == 'Loksabha'
                        ? Text(
                            'Fill Secondary Information',
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          )
                        : Text(
                            'Secondary Information',
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                    spaceHeightWidget(12),
                    widget.type == 'Loksabha'
                        ? CustomDropDown(
                            title: 'Relation',
                            hintText: 'Select Relation',
                            dropDownList: const ['ES', 'DD'],
                          )
                        : CommonTextField(
                            title: 'S/O',
                            hintText: 'Enter Your S/O',
                            controller: soController,
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? TextFieldWidget(
                            controller: fatherNameController,
                            title: 'Father’s / Husband Name',
                            hintText: 'Enter father’s / Husband Name')
                        : CommonTextField(
                            maxLines: 3,
                            title: 'Full Address',
                            hintText: 'Enter Your Full Address',
                            controller: fullAddressController,
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? TextFieldWidget(
                            controller: societyController,
                            title: 'Society',
                            hintText: 'Enter Society')
                        : Row(
                            children: [
                              Expanded(
                                child: CommonTextField(
                                  title: 'Religion',
                                  hintText: 'Enter Your Religion',
                                  controller: religionController,
                                ),
                              ),
                              spaceWidthWidget(9),
                              Expanded(
                                child: CommonTextField(
                                  title: 'WhatsApp No.',
                                  hintText: 'Enter Your WhatsApp No.',
                                  keyboardType: TextInputType.phone,
                                  controller: whatsAppNoController,
                                ),
                              ),
                            ],
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? TextFieldWidget(
                            controller: houseController,
                            title: 'House No.',
                            hintText: 'Enter House No.')
                        : CommonTextField(
                            title: 'Alternate Phone No.',
                            hintText: 'Enter Your Alternate Phone No.',
                            keyboardType: TextInputType.phone,
                            controller: alternatePhoneNoController,
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? TextFieldWidget(
                            controller: streetController,
                            title: 'Street / Block',
                            hintText: 'Enter House No.')
                        : CommonTextField(
                            title: 'Email ID',
                            hintText: 'Enter Street / Block',
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFieldWidget(
                                  controller: adharNoController,
                                  title: 'Enter Aadhar No.',
                                  keyboardType: TextInputType.number,
                                  hintText: 'Aadhar No.'),
                              spaceHeightWidget(8),
                              UploadCard(
                                onTap: (() {}),
                              ),
                            ],
                          )
                        : CommonTextField(
                            title: 'AADHAR No.',
                            hintText: 'Enter Your AADHAR No.',
                            keyboardType: TextInputType.phone,
                            controller: adharNoController,
                            suffixWidget:
                                uploadImage(isUploaded: true, onTap: (() {})),
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFieldWidget(
                                controller: voterIDController,
                                hintText: 'Enter Voter ID No.',
                                title: 'Voter ID No.',
                                keyboardType: TextInputType.number,
                              ),
                              spaceHeightWidget(8),
                              UploadCard(
                                onTap: (() {}),
                              ),
                            ],
                          )
                        : CommonTextField(
                            title: 'Voter ID',
                            hintText: 'Enter Your Voter ID No.',
                            keyboardType: TextInputType.phone,
                            controller: voterIDController,
                            suffixWidget: uploadImage(onTap: (() {})),
                          ),
                    spaceHeightWidget(8),
                    widget.type == 'Loksabha'
                        ? BlocBuilder<AddEntryCubit, AddEntryState>(
                            builder: (context, state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextFieldWidget(
                                    controller: rationCardNoController,
                                    hintText: 'Enter Ration Card No.',
                                    title: 'Ration Card No.',
                                    keyboardType: TextInputType.number,
                                  ),
                                  spaceHeightWidget(8),
                                  UploadCard(
                                    uploadedFilePath:
                                        cubit.pickedFile?.path.substring(53),
                                    onTap: (() async {
                                      await cubit.pickFile();
                                    }),
                                  ),
                                ],
                              );
                            },
                          )
                        : CommonTextField(
                            title: 'Ration Card No.',
                            hintText: 'Enter Your Ration Card No.',
                            keyboardType: TextInputType.phone,
                            controller: rationCardNoController,
                            suffixWidget: uploadImage(onTap: (() {})),
                          ),
                    spaceHeightWidget(10),
                    widget.type == 'Loksabha'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SelectPropertyBox(
                                value: false,
                                title: 'Bike',
                              ),
                              SelectPropertyBox(
                                value: false,
                                title: 'Car',
                              ),
                              SelectPropertyBox(
                                value: false,
                                title: 'Smartphone',
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SelectPropertyBox(
                                value: true,
                                title: 'Bike',
                              ),
                              SelectPropertyBox(
                                value: true,
                                title: 'Car',
                              ),
                              SelectPropertyBox(
                                value: true,
                                title: 'Smartphone',
                              ),
                            ],
                          ),
                    spaceHeightWidget(30),
                    widget.type == 'Loksabha'
                        ? CommonButton(
                            padding: const EdgeInsets.all(12),
                            title: 'Preview & Submit Details',
                            borderRadius: 10,
                            style: GoogleFonts.quicksand(
                                color: AppColor.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CommonButton(
                                  onTap: (() {}),
                                  padding: const EdgeInsets.all(12),
                                  title: 'Edit',
                                  borderRadius: 10,
                                  backGroundcolor: AppColor.white,
                                  style: GoogleFonts.quicksand(
                                      color:
                                          AppColor.buttonOrangeBackGroundColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              spaceWidthWidget(30),
                              Expanded(
                                child: CommonButton(
                                  onTap: (() {}),
                                  padding: const EdgeInsets.all(12),
                                  title: 'Submit',
                                  borderRadius: 10,
                                  style: GoogleFonts.quicksand(
                                      color: AppColor.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                    spaceHeightWidget(30),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  uploadImage({bool isUploaded = false, required GestureTapCallback onTap}) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(right: 6, bottom: 12),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColor.greyColor.withOpacity(0.3))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                isUploaded ? AppIcons.galleryColorImage : AppIcons.galleryImage,
                height: 16,
              ),
              spaceWidthWidget(4),
              Text(
                isUploaded ? 'Adhar Photo-1.JPG' : 'No file uploaded',
                style: GoogleFonts.quicksand(
                    color: AppColor.greyColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }
}