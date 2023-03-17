import 'dart:io';

import 'package:Mate8/controller/sign_up_controller.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chips_input/simple_chips_input.dart';
import '../styles/static_colors.dart';
import '../styles/static_styles.dart';
import 'background_screen.dart';
import '../components/components.dart';

class SignUpDetailScreen extends GetView<SignUpController> {
  const SignUpDetailScreen({Key? key}) : super(key: key);

  //TODO Add Semester Chooser;
  @override
  Widget build(BuildContext context) {
    TextFormFieldStyle style = TextFormFieldStyle(
      keyboardType: TextInputType.text,
      cursorColor: Colors.black12,
      decoration: InputDecoration(
        labelText: 'ChipsInputLabel'.tr,
        labelStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.all(0.0),
        border: InputBorder.none,
      ),
    );
    var screenHeight = MediaQuery.of(context).size.height;
    return Hero(
      tag: 'onGoingAnimation',
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          title: Text('Details',
              style: TextStyle(color: StaticColors.primaryFontColor)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
        ),
        backgroundColor: StaticColors.secondaryColor,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: StaticColors.primaryColor,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(StaticStyles.borderRadius))),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(children: [
                buildProfileImageContainer(),
                buildSubheading('Allgemeine Informationen'),
                CustomTextFormField("Name".tr,
                    controller: controller.nameTextEditingController,
                    iconData: Icons.person),
                buildSubheading('Weitere Informationen'),
                GestureDetector(
                  onTap: () => controller.onCountryPickerTapped(context),
                  child: CustomTextFormField(
                    "Nationalität",
                    isEnabled: false,
                    iconData: Icons.flag,
                    controller: controller.nationalityTextEditingController,
                  ),
                ),
                GestureDetector(
                  onTap: controller.onAgePickerTapped,
                  child: CustomTextFormField(
                    "Alter",
                    isEnabled: false,
                    isNumeric: true,
                    iconData: Icons.calendar_month,
                    controller: controller.ageTextEditingController,
                  ),
                ),
                GestureDetector(
                  onTap: controller.onUniversityDepartmentTapped,
                  child: CustomTextFormField(
                    isEnabled: false,
                    "Fachbereich",
                    iconData: Icons.arrow_drop_down_sharp,
                    controller:
                        controller.universityDepartmentTextEditingController,
                  ),
                ),
                buildSubheading('Beschreibung'),
                CustomTextFormField(
                  "Beschreibung angeben",
                  isMultiLine: true,
                  iconData: Icons.description,
                  controller: controller.descriptionTextEditingController,
                ),
                const SizedBox(
                  height: 20,
                ),
                buildTitle(),
                _buildSubTitle(),
                const SizedBox(
                  height: 30,
                ),
                _buildChipsInput(style),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  "Abschließen",
                  color: Colors.white,
                  onTap: controller.setProfile,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Text buildTitle() {
    return Text(
      "DescribeIn5Words".tr,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: StaticColors.secondaryFontColor,
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  SimpleChipsInput _buildChipsInput(TextFormFieldStyle style) {
    return SimpleChipsInput(
      separatorCharacter: ",",
      validateInput: true,
      onSubmitted: controller.onDescriptionChipsSubmitted,
      textFormFieldStyle: style,
      chipTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      deleteIcon: const Icon(
        Icons.remove_circle_outline,
        size: 14.0,
        color: Colors.black,
      ),
      widgetContainerDecoration: BoxDecoration(
        color: StaticColors.secondaryColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.blue[100]!, width: 0),
      ),
      chipContainerDecoration: BoxDecoration(
        color: StaticColors.primaryColor,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(50),
      ),
      placeChipsSectionAbove: false,
    );
  }

  Text _buildSubTitle() {
    return Text(
      "DescribeIn5WordsExample".tr,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Center buildProfileImageContainer() {
    return Center(
      child: GestureDetector(
        onTap: controller.pickImage,
        child: Obx(
          () => Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(controller.file.value))),
          ),
        ),
      ),
    );
  }

  Widget buildSubheading(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
